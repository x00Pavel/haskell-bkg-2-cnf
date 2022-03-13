# Projekt: Prevod bezkontextové vlastní gramatiky (dále BKG) na bezkontextové gramatiky v Chomského normální formě
# Nazev: BKG-2-CNF
# Autor: Pavel Yadlouski (xyadlo00)
# Rok: 2021/2022

from extra import PROG
from extra.conftest import file_in_file_out
from subprocess import check_output, PIPE
import pytest


@pytest.mark.parametrize("file_in,file_out", file_in_file_out("simplify"))
def test_basic_remove_simple(file_in, file_out):
    if file_out is None:
        pytest.skip(f"No out file for in file {file_in}")

    cmd = [PROG, file_in, "-1"]
    out_lines = check_output(cmd, encoding="utf-8", stderr=PIPE).split("\n")
    test_non_term = out_lines[0].split(",")
    test_rules = out_lines[3:]

    with open(file_out, "r") as f:
        cnt = f.read().split("\n")
    header = cnt[:3]
    non_term = header[0].split(",")
    rules = cnt[3:]
    
    for nt in non_term:
        assert nt in test_non_term

    for r in rules:
        assert r in test_rules

