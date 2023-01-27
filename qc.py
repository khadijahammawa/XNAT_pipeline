import os
from pydicom import dcmread

# 1) Declare constant variables
SUBID = input('Enter subject ID (i.e. 00012345): ')
SESSIONNUM = input('Enter Session Number (i.e. 1, 2): ')
VISITNUM = input('Enter visit number (1) or (2): ')
SUBFOLDER = f'C:/Users/Khadija_Hammawa/Documents/GitHub/xnat_sftp/BDV01_CMH_{SUBID}/ses-{SESSIONNUM}'

# 2) Add error handling for variable names
try:
    SUBID = int(SUBID)
    if len(str(SUBID)) != 8:
        raise ValueError
except ValueError:
    print("Error: Subject ID must be an 8-digit number")
    exit()

try:
    SESSIONNUM = int(SESSIONNUM)
    if len(str(SESSIONNUM)) !=1:
        raise ValueError
except ValueError:
    print('Error: Session number should be a one-digit number')
    exit()
    
try:
    VISITNUM = int(VISITNUM)
    if len(str(VISITNUM)) !=1 or VISITNUM !=1 or VISITNUM !=2:
        raise ValueError
except ValueError:
    print('Error: Session number should be a one-digit number')
    exit() 

# 3)
for root, dirs, files in os.walk(SUBFOLDER):
    for dcm in files:
        fpath = os.path.join(root,dcm)
        ds = dcmread(fpath, force=True)
        print('Old experiment label', ds.PatientName)
        exp_label = f'BDV01_CMH_{SUBID}_{VISITNUM}_SE0{SESSIONNUM}_MR'
        ds.PatientName = exp_label
        print('New experimental label: ', ds.PatientName)

#Add a progress bar or status update to show how many DICOM files have been processed and how many are left.
#Use argparse package to get the input from command line arguments instead of input() function.
#Use a DICOM library that allows for handling large datasets and bulk update and save the DICOM files.
#Use try-except block and handle different types of exceptions that might occur when reading and writing the DICOM files.


print('DICOM labels corrected')