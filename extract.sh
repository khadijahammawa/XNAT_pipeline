#!/bin/bash

# 1) download scans from TONI
sh ./download_toni.sh $ROOTDIR

# 2) create participant folder on local computer
sh ./create_participant_folder.sh $ROOTDIR $SUBID $VISITNUM