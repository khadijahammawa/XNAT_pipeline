#!/bin/bash

# 1) download scans from TONI
sh ./download_toni.sh $SUBID $ROOTDIR

# 2) create participant folder on local computer
sh ./create_participant_folder.sh $SUBID $ROOTDIR