import pytest
from . import PROG, ROOT
from subprocess import PIPE, run
from os.path import exists
from os import listdir


@pytest.fixture(scope="session", autouse=True)
def compile():
    cmd = ["make", "testbuild", '-C', ROOT]
    run(cmd, encoding='utf8', stdout=PIPE, stderr=PIPE, check=True)
    assert exists(PROG)


# @pytest.fixture()
def all_test_in(dir_):
    files = listdir(dir_)
    files = (f"{dir_}/{name}" for name in files)
    return files
