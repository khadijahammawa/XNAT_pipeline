#!/bin/bash

# 1)
# location of folder where you want to download scans
ROOTDIR='/c/Users/Khadija_Hammawa/Documents/GitHub/xnat_sftp'
cd $ROOTDIR
pwd

echo 'Enter your USERID: '
read USERID

# 2)
# connect to TONI server and follow instructions when prompted to enter your password
sftp -P 14766 $USERID@echo.toni.psych.utoronto.ca

echo 'Enter SUBID: '
read SUBID

# 4)
# make folder with appropriate naming convention
# SUBID will have format of '000#####'
mkdir $ROOTDIR/BDV01_CMH_$SUBID

# 5)
# make folder to distinguish between first scan and second scan
mkdir $ROOTDIR/BDV01_CMH_$SUBID/ses-1
mkdir $ROOTDIR/BDV01_CMH_$SUBID/ses-2

echo 'Are you downloading the scans for the first visit or second? (1) or (2): '
read SCANNUM

# 6)
# copy contents into new subject folder
cp -r $ROOTDIR/BDV01-CMH-$SUBID_*/. $ROOTDIR/BDV01_CMH_$SUBID/ses-$SCANNUM

# 7)
# remove old folder (also makes it easy for re-running script)
rm -r $ROOTDIR/BDV01-CMH-$SUBID*/*

# 7)
echo 'Subject folder downloaded.'
