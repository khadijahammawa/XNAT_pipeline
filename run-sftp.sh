#!/bin/bash

# 1) first download scans from TONI
download.sh

# 2) Zip subject folder
zip.py

######
# QC #
######

# 2) upload scans to XNAT server
upload.py
