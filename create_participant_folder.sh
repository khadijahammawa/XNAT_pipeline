#!/bin/bash

# 1) Create the subject folder with the appropriate naming convention
SUBJECT_FOLDER="$ROOTDIR/BDV01_CMH_$SUBID"

if ! mkdir "$SUBJECT_FOLDER"; then
    echo "Error: Failed to create subject folder $SUBJECT_FOLDER" >&2
    exit 1
fi

# 2) Create the first and second visit folders
if ! mkdir "$SUBJECT_FOLDER/ses-1" || ! mkdir "$SUBJECT_FOLDER/ses-2"; then
    echo "Error: Failed to create visit folders for $SUBJECT_FOLDER" >&2
    exit 1
fi

# 3) Ask the user which visit they are downloading
echo 'Are you downloading the scans for the first visit or second? (1) or (2): '
read SCANNUM

# 4) Define the source and destination folders
SOURCE_FOLDER="$ROOTDIR/BDV01-CMH-$SUBID_*"
DEST_FOLDER="$SUBJECT_FOLDER/ses-$SCANNUM"

# 5) Copy the contents of the subject folder to the correct session day
cp -r $SOURCE_FOLDER $DEST_FOLDER

# 6) Remove the original subject folder
rm -r $SOURCE_FOLDER

echo 'Subject folder downloaded'
