from . import PROG
from subprocess import check_output, run, PIPE


def test_basic_remove_simple():
    file_in = "./simplify/basic.in"
    file_out = "./simplify/basic.out"
    
    cmd = [PROG, file_in, "-1"]
    out = check_output(cmd, encoding="utf-8", stderr=PIPE)

    with open(file_out, "r") as f:
        assert f.read() in out