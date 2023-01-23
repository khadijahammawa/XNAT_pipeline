import os
from pydicom import dcmread


SUBID = input('Enter subject ID (i.e. 00012345): ')
SESSIONNUM = input('Enter Session Number (i.e. 1, 2): ')
VISITNUM = input('Enter visit number (1) or (2): ')
SUBFOLDER = f'C:/Users/Khadija_Hammawa/Documents/GitHub/xnat_sftp/BDV01_CMH_{SUBID}/ses-{SESSIONNUM}'

for root, dirs, files in os.walk(SUBFOLDER):
    for dcm in files:
        fpath = os.path.join(root,dcm)
        ds = dcmread(fpath, force=True)
        print('Old experiment label', ds.PatientName)
        exp_label = f'BDV01_CMH_{SUBID}_{VISITNUM}_SE0{SESSIONNUM}_MR'
        ds.PatientName = exp_label
        print('New experimental label: ', ds.PatientName)

print('DICOM labels corrected')






























'''
from datman.scan_list import ScanEntryABC, generate_scan_list
import os

study = 'BDV01'
site = 'CMH'
subid = '00000001'
timepoint = '01'
session = '01'
scan_path = 'C:/Users/Khadija_Hammawa/Documents/GitHub/xnat_sftp'

class subjectScanEntry(ScanEntryABC):
    def __init__(self, scan_path):
        super(subjectScanEntry, self).__init__(scan_path)
    
    def get_target_name(self, study, site, subid, timepoint, session):
        self.study = study
        self.site = site
        self.subid = subid
        self.timepoint = timepoint
        self.session = session

        datman_id = f'{study}_{site}_{subid}_{timepoint}_{session}'
        return datman_id

sub_scan = subjectScanEntry(scan_path=scan_path)
datmanid = sub_scan.get_target_name(study=study, site=site, subid=subid, timepoint=timepoint, session=session)

generate_scan_list(sub_scan, zip_files=['BDV01_CMH_00000001.zip'], dest_dir= os.getcwd())
'''