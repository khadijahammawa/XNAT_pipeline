#!/bin/bash

# 1) Declare variables
echo 'Enter SUBID (e.g. 00012345): '
read SUBID
ROOTDIR='/c/Users/Khadija_Hammawa/Documents/GitHub/xnat_sftp'

cd $ROOTDIR

# 1) first download scans from TONI
#sh ./download.sh $ROOTDIR
#echo "Participant folder downloaded."

sh ./create_participant_folder.sh $ROOTDIR $SUBID

# 2) run quality control (modify exp label)
#python qc.py
#echo "QC is complete."

# 3) zip dicom files for upload to XNAT
python zip.py
echo "Participant folder ready for upload."

# 4) upload files to xnat
# WIP