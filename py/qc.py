import os
from pydicom import dcmread

MAIN_FOLDER = 'C:/Users/Khadija_Hammawa/Documents/GitHub/xnat_sftp'
VAR_PATH = f'{MAIN_FOLDER}/vars.txt'


with open(VAR_PATH) as f:
    for line in f:
        exec(line)

SUBID = SUBID
SESSIONNUM = SESSIONNUM
VISITNUM = VISITNUM

SUBFOLDER = f'{MAIN_FOLDER}/BDV01_CMH_000{SUBID}/ses-{VISITNUM}'

# 1) Add error handling for variable names
try:
    SUBID = int(SUBID)
    if len(str(SUBID)) != 5:
        raise ValueError
except ValueError:
    print("Error: Subject ID must be an 5-digit number")
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
    if VISITNUM > 2:
        raise ValueError
except ValueError:
    print('Error: Visit number should be either 1 or 2')
    exit() 

# 2) Change PatientName in the header file for each dicom file
for root, dirs, files in os.walk(SUBFOLDER):
    for dcm in files:
        fpath = os.path.join(root,dcm)
        ds = dcmread(fpath, force=True)
        print('Old experiment label', ds.PatientName)
        exp_label = f'BDV01_CMH_000{SUBID}_0{VISITNUM}_SE0{SESSIONNUM}_MR'
        ds.PatientName = exp_label
        print('New experimental label: ', ds.PatientName)
        ds.save_as(fpath)

print('DICOM labels corrected.')