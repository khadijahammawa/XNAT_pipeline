import os
import pytest
import subprocess

@pytest.fixture
def rootdir():
    return '/path/to/rootdir'

@pytest.fixture
def subid():
    return '123'

@pytest.fixture
def visitnum():
    return '1'

def test_create_participant_folder_success(rootdir, subid, visitnum):
    with subprocess.Popen(['./create_participant_folder.sh', rootdir, subid, visitnum], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, encoding='utf8') as proc:
        output, error = proc.communicate()
        assert proc.returncode == 0
        assert f'Participant {subid} Folder Created.' in output
        assert f'Participant {subid} Scans Copied Sucessfully.' in output

        subject_folder = os.path.join(rootdir, f'BDV01_CMH_000{subid}')
        visit_folder = os.path.join(subject_folder, f'ses-{visitnum}')
        assert os.path.exists(subject_folder)
        assert os.path.exists(visit_folder)

        # cleanup
        os.remove(os.path.join(visit_folder, 'file1.txt'))
        os.remove(os.path.join(visit_folder, 'file2.txt'))
        os.rmdir(visit_folder)
        os.rmdir(subject_folder)

def test_create_participant_folder_failure(rootdir, subid, visitnum):
    with subprocess.Popen(['./create_participant_folder.sh', rootdir, subid, visitnum], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, encoding='utf8') as proc:
        output, error = proc.communicate()
        assert proc.returncode != 0
        assert f"mkdir: cannot create directory '{rootdir}/BDV01_CMH_000{subid}': File exists" in error
