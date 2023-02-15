#!/bin/bash

ROOTDIR='/c/Users/Khadija_Hammawa/Documents/GitHub/xnat_sftp'
cd $ROOTDIR
export ROOTDIR

echo "Enter participants ID (i.e. 12345): "
read SUBID
export SUBID

echo "Enter Session Number (i.e. 1, 2): "
read SESSIONNUM
export SESSIONNUM

echo "Enter Visit Number (1 or 2): "
read VISITNUM
export VISITNUM

echo "SUBID=$SUBID" > vars.txt
echo "SESSIONNUM=$SESSIONNUM" >> vars.txt
echo "VISITNUM=$VISITNUM" >> vars.txt 

# 1) EXTRACT
echo "====================EXTRACTION BEGINNING====================="
sh ./extract.sh $ROOTDIR $SUBID $VISITNUM
echo "=====================EXTRACTION COMPLETE====================="

# 2) TRANSFORM
echo "===================TRANSFORMATION STARTED===================="
sh ./transform.sh $SUBID
echo "==========TRANSFORMATION COMPLETE, READY FOR UPLOAD=========="

# 3) LOAD (WIP)
echo "==================UPLOAD PROCESS BEGINNING==================="
#sh ./load.sh
echo "======PARTICIPANT $SUBID FOLDER UPLOADED TO PREARCHIVE======="