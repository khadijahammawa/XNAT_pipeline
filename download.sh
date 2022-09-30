#!/bin/bash

# 1)
# location of folder where you want to dowload scans
cd /c/Users/Khadija_Hammawa/Documents/GitHub/XNAT_pipeline

#echo 'Enter your USERID: '
#read USERID

# 2)
# connect to TONI server and follow instructions when prompted to enter your password
#sftp -P 14766 $USERID@echo.toni.psych.utoronto.ca

echo 'Enter SUBID: '
read SUBID
export SUBID

# 3)
# download all folders & subfolders of subject
#Get -r BDV01-CMH-$SUBID*

# 4)
# make folder with appropriate naming convention
mkdir /c/Users/Khadija_Hammawa/Documents/GitHub/XNAT_pipeline/BDV01_CMH_$SUBID

# 5)
# copy contents into new subject folder
cp -r /c/Users/Khadija_Hammawa/Documents/GitHub/XNAT_pipeline/BDV01-CMH-$SUBID_*/* /c/Users/Khadija_Hammawa/Documents/GitHub/XNAT_pipeline/BDV01_CMH_$SUBID

# 6)
# remove old folder (also makes it easy for re-running script)
#rm /c/Users/Khadija_Hammawa/Documents/GitHub/XNAT_pipeline/BDV01-CMH-$SUBID*/*