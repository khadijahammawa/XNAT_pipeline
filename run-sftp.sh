#!/bin/bash

# 1) first download scans from TONI
download.sh

# 2) run quality control (modify exp label)
qc.py

# 3) zip dicom files for upload to XNAT
zip.py

# 4) upload files to xnat
# WIP