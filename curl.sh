#!/bin/bash

# To run the script, type bash curl.sh ${PROJECT NUMBER} in the terminal.
# This is a script that automates MRI data download from an XNAT server using cURL.
# The settings you will need to change for this script are the download directories.
# As a security measure, this script asks for user input to obtain username and password.
# However for your convenience, there are default locations where you can save these variables.
# This allows this script can be run automatically using crontab using the dummy terminal to autofill default variables.
# UPDATE: This script now creates the project folder if the folder has not been created previously.

# Developed by Darren Liang
# Last updated 4 Mar 2020

# If an error occurs, stop the script
set -e

echo "Starting curl.sh..."

# Set download server
XNAT=https://rrinid.rotman-baycrest.on.ca/spred/data/projects;

if [ "dumb" == "$TERM" ]; then
XNATUserName=${USER}; 
XNATPassword=`cat ~/.netrc`

else
# Log into XNAT using own credentials
echo -n "Please enter your UserName for XNAT: "
read -e userInput
if [ -z "$userInput" ]; then
XNATUserName=${USER}; #if username is not entered, use default user
else
XNATUserName=${userInput};
fi
echo -n "Please enter the Password for ${XNATUserName}: "
read -e -s userInput
if [ -z "$userInput" ]; then
XNATPassword=`cat ~/.netrc` #if password is not entered, use saved password
else
XNATPassword=${userInput};
fi
fi

if [ -z "${@}" ]; then
echo "No project argument supplied, default to downloading all projects."
ProjectList="142 163";
else
ProjectList=${@};
fi

# Set projects to download from to the target directory
for ProjectID in ${ProjectList}; do
Project=MaLi_M${ProjectID}_BA;
ProjectID=$(echo ${Project} | sed 's/[^0-9]*//g');

# Set download directory for data
projdir=$(echo /rri_disks/antigone/`id -gn`/data/*${ProjectID}*);
mridir=${projectdir}/mri;
physiodir=${projectdir}/physio;
niftidir=${projectdir}/nifti
SUBJECTS_DIR=${projectdir}/recon
FUNCTIONALS_DIR=${projectdir}/fsfast

# Check if directory exists or create project directories
if [ ! -d ${projdir} ]; then
mkdir ${projdir}
mkdir ${mridir}
mkdir ${physiodir}
mkdir ${niftidir}
mkdir ${SUBJECTS_DIR}
mkdir ${FUNCTIONALS_DIR}
fi


# Begin looping into XNAT
echo
echo "Getting subjects list for project ${Project}."

{
read #read out first line (labels)
while IFS=' ,' read -r ID project label insert_date insert_user insert_time URI; do

# Set subjects environment based on read data from XNAT
SubjectID=$(echo "${label//[!0-9]/}" | sed -e "s/^${ProjectID}//");


{
read #read out first line (labels)
while IFS=' ,' read -r ID ID project scandate scanType label insert_date URI; do

# Set experiment name based on read data from XNAT
ExperimentID=$(echo "${label//\"}");

# Check experiment type to run download
if [[ ${ExperimentID} == *MRI* ]]; then

ScanDate=$(echo "${ExperimentID}" | sed "s/.*MRI_//g");

# Nested: check for existence of MRI data in data directory and download if it has not been downloaded yet
if [ -d ${mridir}/${SubjectID}_${ScanDate} ]; then
echo "Data directory for ${SubjectID}_${ScanDate} exists, MRI download not required. Continuing..."
else
echo "Data directory for ${SubjectID}_${ScanDate} not found. Checking for MRI data to download from:"
URL=${XNAT}/${Project}/subjects/${Project}_${SubjectID}/experiments/${ExperimentID}/scans/ALL/resources/DICOM/files?format=zip
echo ${URL}
curl -f -k -u ${XNATUserName}:${XNATPassword} -X GET -o ${Project}_${SubjectID}_MRI.zip --url ${URL}

# Nested 2: if it downloaded data, then unpack it
if [ -f ${Project}_${SubjectID}_MRI.zip ]; then
unzip ${Project}_${SubjectID}_MRI.zip -d ${mridir}/
mv ${mridir}/${ExperimentID}/scans ${mridir}/${SubjectID}_${ScanDate}
echo "Data directory created for ${SubjectID}_${ScanDate} in ${mridir}/"
rm ${Project}_${SubjectID}_MRI.zip
rm -r ${mridir}/${ExperimentID}/
else
echo "Warning: File not found. Continuing without the MRI files for ${SubjectID}."
fi
fi

elif [[ ${ExperimentID} == *Physio* ]]; then

ScanDate=$(echo "${ExperimentID}" | sed "s/.*PhysioData_//g");

# Nested: check for existence of Physio data in data directory and download if it has not been downloaded yet
if [ -d ${physiodir}/${SubjectID}_${ScanDate} ]; then
echo "Data directory for ${SubjectID}_${ScanDate} exists, Physio download not required. Continuing..."
else
echo "Data directory for ${SubjectID}_${ScanDate} not found. Checking for Physio data to download from:"
URL=${XNAT}/${Project}/subjects/${Project}_${SubjectID}/experiments/${ExperimentID}/scans/ALL/files?format=zip
echo ${URL}
curl -f -k -u ${XNATUserName}:${XNATPassword} -X GET -o ${Project}_${SubjectID}_physio.zip --url ${URL}

# Nested 2: if it downloaded data, then unpack it
if [ -f ${Project}_${SubjectID}_physio.zip ]; then
unzip ${Project}_${SubjectID}_physio.zip -d ${physiodir}/
unzip ${physiodir}/${ExperimentID}/scans/1-PhysioFiles/resources/PhysioData/files/*.zip -d ${physiodir}/
mv ${physiodir}/fmri* ${physiodir}/${SubjectID}_${ScanDate}
echo "Data directory created for ${SubjectID}_${ScanDate} in ${physiodir}/"
rm ${Project}_${SubjectID}_physio.zip
rm -r ${physiodir}/${ExperimentID}/
else
echo "Warning: File not found. Continuing without the Physio files for ${SubjectID}."
fi
fi

else
echo "File type does not match to any type of MRI related data. Moving along now..."
fi

done
} < <(curl -k -u ${XNATUserName}:${XNATPassword} -X GET --url ${XNAT}/${Project}/subjects/${Project}_${SubjectID}/experiments?format=csv)

done
} < <(curl -k -u ${XNATUserName}:${XNATPassword} -X GET --url ${XNAT}/${Project}/subjects?format=csv)

done
echo "curl.sh has completed and bash has stopped."
