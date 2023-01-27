#!/bin/bash

# 1) QC
python qc.py $SUBID $SESSIONNUM $VISITNUM

# 2) TAR
python zip.py