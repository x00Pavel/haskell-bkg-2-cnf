from . import PROG
from subprocess import check_output, run, PIPE
import pytest
from extra.conftest import file_in_file_out


@pytest.mark.parametrize("file_in,file_out", file_in_file_out("cnf"))
def test_basic_cnf(file_in, file_out):
    cmd = [PROG, file_in, "-2"]
    out = check_output(cmd, encoding="utf-8")
    out_lines = out.split("\n")

    with open(file_out, "r") as f:
        lines = f.read().split("\n")
    header = lines[:3]
    rules = lines[3:]
    non_terms = header[0].split(",")

    test_non_terms = out_lines[0].split(",")
    test_rules = out_lines[3:]

    for nt in non_terms:
        assert nt in test_non_terms

    for r in rules:
        assert r in test_rules