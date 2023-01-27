import os.path
from os.path import basename
from tarfile import TarFile

#from qc import SESSIONNUM, SUBID
SUBID= '00000001'
SESSIONNUM=1

# 1) Define main folders
MAIN_FOLDER = 'C:/Users/Khadija_Hammawa/Documents/GitHub/xnat_sftp'
subFolder = f'{MAIN_FOLDER}/BDV01_CMH_{SUBID}/ses-{SESSIONNUM}'
tarFolder = f'{MAIN_FOLDER}/BDV01_CMH_{SUBID}.gz'

# create a ZipFile object
with TarFile(tarFolder, 'w') as tar:
   # Iterate over all the files in directory
   for folderName, subfolders, filenames in os.walk(subFolder):
    for filename in filenames:
        #create complete filepath of file in directory
        filePath = os.path.join(folderName, filename)
        # Add file to tar archive
        tar.add(filePath, arcname=basename(filePath))

print(f'Subject {SUBID} zip folder created')