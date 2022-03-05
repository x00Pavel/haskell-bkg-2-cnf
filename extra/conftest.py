import pytest
from extra import PROG, ROOT
from subprocess import PIPE, run
from os.path import exists, splitext, join
from os import listdir


@pytest.fixture(scope="session", autouse=True)
def compile():
    cmd = ["make", "testbuild", '-C', ROOT]
    run(cmd, encoding='utf8', stdout=PIPE, stderr=PIPE, check=True)
    assert exists(PROG)


def all_test_in(dir_):
    files = listdir(dir_)
    files = (f"{dir_}/{name}" for name in files)
    return files

def file_in_file_out(dir_):
    files = listdir(dir_)
    out = []
    files_in = [f for f in files if f.endswith(".in")] # list(filter(lambda x : print(x) (splitext(x)[1] == "in"), files))
    print(files_in)
    files_out = [f for f in files if f.endswith(".out")]
    for f in files_in:
        name = splitext(f)[0]
        out_name = f"{name}.out"
        if out_name in files_out:
            out.append((join(dir_, f), join(dir_, out_name)))
        else:
            out.append((join(dir_, f), None))
    return out



