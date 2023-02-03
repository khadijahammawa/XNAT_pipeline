#!/bin/bash

# 1) Create the subject folder with the appropriate naming convention
SUBJECT_FOLDER="$ROOTDIR/BDV01_CMH_000$SUBID"
mkdir $SUBJECT_FOLDER

# 2) Create the first and second visit folders
mkdir "$SUBJECT_FOLDER/ses-1"
mkdir "$SUBJECT_FOLDER/ses-2"

# 3) Define the source and destination folders
SOURCE_FOLDER=$ROOTDIR/BDV01-CMH-*/.
DEST_FOLDER="$SUBJECT_FOLDER/ses-$VISITNUM"

# 4) Copy the contents of the subject folder to the correct session day
cp -r "$SOURCE_FOLDER" "$DEST_FOLDER"

# 5) Remove the original subject folder
rm -r $SOURCE_FOLDER

echo "Participant Folder Created."
