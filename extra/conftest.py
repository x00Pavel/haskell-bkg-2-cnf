from pkgutil import extend_path
import pytest
from . import PROG, ROOT
from subprocess import PIPE, run
from os.path import exists


@pytest.fixture(scope="session", autouse=True)
def compile():
    cmd = ["make", "testbuild", '-C', ROOT]
    run(cmd, encoding='utf8', stdout=PIPE, stderr=PIPE, check=True)
    assert exists(PROG)
