import os.path
from os.path import basename
from tarfile import TarFile
from qc import SUBID, SUBFOLDER, MAIN_FOLDER

# 1) Define main folders
tarFolder = f'{MAIN_FOLDER}/BDV01_CMH_000{SUBID}.gz'

# 2) Create a ZipFile object
with TarFile(tarFolder, 'w') as tar:
   # Iterate over all the files in directory
   for folderName, subfolders, filenames in os.walk(SUBFOLDER):
    for filename in filenames:
        # Create complete filepath of file in directory
        filePath = os.path.join(folderName, filename)
        # Add file to tar archive
        tar.add(filePath, arcname=basename(filePath))

print(f'Subject {SUBID} zip folder created')