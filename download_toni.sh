#!/bin/bash

# 1) Change to the root directory
if ! cd "$ROOTDIR"; then
    echo "Error: Failed to change to directory $ROOTDIR" >&2
    exit 1
fi

# 2) Get the USERID
if [ -z "$1" ]; then
    echo 'Enter your USERID: '
    read USERID
else
    USERID="$1"
fi

# 3) Connect to the TONI server
if ! sftp -P 14766 "$USERID@echo.toni.psych.utoronto.ca"; then
    echo "Error: Failed to connect to the TONI server" >&2
    exit 1
fi

echo 'Participant folder downloaded from TONI server'
