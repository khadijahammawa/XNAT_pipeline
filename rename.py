'''
numberofdirs=
subid=
visitcode=
session=
'''
import os
import numpy as np

# VARIABLES
subid = '00000001' #input('Enter subject ID: ')
visitCode = '01' #input('Enter visit code (01 or 02): ')
pwd = os.getcwd()
print('present working dir: ',pwd)
numberofDirs = len(os.listdir(f'{pwd}/BDV01_CMH_{subid}'))
print('numer of dirs in subject folder: ', numberofDirs)

for i, scan in enumerate(os.listdir(f'{pwd}/BDV01_CMH_{subid}')):
    print(i, scan)
    


#foldername= 'BDV01_CMH_{00000001}_{01}_SE{06}_MR'