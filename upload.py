import xnat
from zip import rootDir
from zip import zipFolder
from zip import subFolder

# connect to server
session = xnat.connect('https://xnat.camh.ca', user='khadija_hammawa')

# import data onto xnat
session.services.import_(f'{rootDir}/{zipFolder}', project='BDV01', subject=f'{subFolder}')

# close connection to server
session.disconnect()