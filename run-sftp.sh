#!/bin/bash

cd /c/Users/Khadija_Hammawa/Documents/GitHub/xnat_sftp

# 1) first download scans from TONI
sh ./download.sh
echo "Participant folder downloaded."

# 2) run quality control (modify exp label)
python qc.py
echo "QC is complete."

# 3) zip dicom files for upload to XNAT
python zip.py
echo "Participant folder ready for upload."

# 4) upload files to xnat
# WIP