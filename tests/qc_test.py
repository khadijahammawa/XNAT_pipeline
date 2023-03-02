import os
from pydicom import dcmread

fpath = input('Path to the folder of interest: ')

for root, dirs, files in os.walk('C:/Users/Khadija_Hammawa/Documents/GitHub/xnat_sftp/BDV01_CMH_00012003'):
    for dcm in files:
        fpath = os.path.join(root,dcm)
        ds = dcmread(fpath, force=True)
        print('Experiment Label', ds.PatientName)