#!/bin/bash

echo "Enter participants ID (i.e. 00012345): "
read SUBID

echo "Enter Session Number (i.e. 1, 2): "
read SESSIONNUM

echo "Enter Visit Number (1 or 2): "
read VISITNUM


ROOTDIR='/c/Users/Khadija_Hammawa/Documents/GitHub/xnat_sftp'
cd $ROOTDIR

# 1) EXTRACT
sh ./extract.sh $ROOTDIR $SUBID
echo "Extraction of participant DICOMS is complete"

# 2) TRANSFORM
sh ./transform.sh $ROOTDIR $SUBID $SESSIONNUM $VISITNUM

# 3) LOAD
#sh ./load.sh