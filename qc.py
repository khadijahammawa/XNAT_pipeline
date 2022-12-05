import os
import pydicom
from pydicom.data import get_testdata_files
from pydicom import dcmread
from zip import subid, subFolder

fpath = get_testdata_files("CT_small.dcm")[0]
ds = dcmread(fpath)

for dicom in subFolder:
    print(os.walk)

#SUBID = subid
#SESSIONNUM = input('Enter Session Number (i.e. 1, 2): ')
#VISITNUM = input('Enter visit number (1) or (2): ')

#for dicom_file in 

#print('Original experiment label:', ds.PatientName)

#experiment_label = f'BDV01_CMH_{SUBID}_{VISITNUM}_SE0{SESSIONNUM}_MR'
#ds.PatientName = experiment_label

#print('New experiment label:', ds.PatientName)

for dicom in subFolder:






























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