#!/bin/bash

#first download scans from TONI
download.sh

#next ensure correct XNAT naming convention
python rename.py

#last upload scans to XNAT
#upload.sh


