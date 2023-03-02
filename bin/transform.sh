#!/bin/bash
source /c/Users/Khadija_Hammawa/Documents/GitHub/xnat_sftp/vars.txt

# 1) QC
python qc.py

# 2) TAR
tar -czvf BDV01_CMH_000$SUBID.tar.gz BDV01_CMH_000$SUBID/

