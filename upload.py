import xnat
import os.path
from os.path import basename 
from zipfile import ZipFile

# connect to server
session = xnat.connect('https://xnat.camh.ca', user='khadija_hammawa')

# retrieve subid
subid = input('Enter subject ID (i.e. 00012345): ')

# init main folders
subFolder = f'BDV01_CMH_{subid}'
zipFolder = f'BDV01_CMH_{subid}.zip'
rootDir = 'C:/Users/Khadija_Hammawa/Documents/GitHub/xnat_sftp'

# create a ZipFile object
with ZipFile(zipFolder, 'w') as zipObj:
   # Iterate over all the files in directory
   for folderName, subfolders, filenames in os.walk(subFolder):
       for filename in filenames:
           #create complete filepath of file in directory
           filePath = os.path.join(folderName, filename)
           # Add file to zip
           zipObj.write(filePath, basename(filePath))

print(f'Subject {subid} zip folder created')

# importign data to xnat
rootDir = 'C:/Users/Khadija_Hammawa/Documents/GitHub/xnat_sftp'
session.services.import_(f'{rootDir}/{zipFolder}', project='BDV01', subject=f'{subFolder}')

# close connection to server
#session.disconnect()