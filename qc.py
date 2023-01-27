import argparse
import os

from pydicom import dcmread

parser = argparse.ArgumentParser()
#parser.add_argument("SUBID", help="Subject ID (i.e. 00012345)", type=str)
#parser.add_argument("SESSIONNUM", help="Session Number (i.e. 1, 2)", type=int)
#parser.add_argument("VISITNUM", help="Visit Number (1) or (2)", type=int)
args = parser.parse_args()

SUBID = args.SUBID
SESSIONNUM = args.SESSIONNUM
VISITNUM = args.VISITNUM

SUBFOLDER = f'C:/Users/Khadija_Hammawa/Documents/GitHub/xnat_sftp/BDV01_CMH_{SUBID}/ses-{SESSIONNUM}'

# 1) Add error handling for variable names
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

# 2)
for root, dirs, files in os.walk(SUBFOLDER):
    for dcm in files:
        fpath = os.path.join(root,dcm)
        ds = dcmread(fpath, force=True)
        print('Old experiment label', ds.PatientName)
        exp_label = f'BDV01_CMH_{SUBID}_{VISITNUM}_SE0{SESSIONNUM}_MR'
        ds.PatientName = exp_label
        print('New experimental label: ', ds.PatientName)

print('DICOM labels corrected')