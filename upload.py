import xnat
from zip import tarFolder

TAR_SUBFOLDER=tarFolder
PROJ='BDV01_CMH'
DEST='/prearchive'
# connect to server
session = xnat.connect('https://xnat.camh.ca/xnat', user='khadija_hammawa')

# create subject
project = session.projects[PROJ]
print(session.SubjectData())
#subject = session.classes.SubjectData(parent=project, label='new_subject_label')

# import data to prearchive
#prearchive_session = session.services.import_(TAR_SUBFOLDER, project=PROJ, destination=DEST)

# close connection to server
session.disconnect()