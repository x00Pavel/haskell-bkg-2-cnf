# Projekt: Prevod bezkontextové vlastní gramatiky (dále BKG) na bezkontextové gramatiky v Chomského normální formě
# Nazev: BKG-2-CNF
# Autor: Pavel Yadlouski (xyadlo00)
# Rok: 2021/2022

from subprocess import PIPE, Popen, run

import pytest
from extra import PROG


def test_stdin(caplog):
    file_in = "./args/test-i-1.in"
    file_out = "./args/test-i-1.out"
    with open(file_in, "r") as f:
        text = f.read()

    cmd = [PROG, "-i", "-1"]
    p = Popen(cmd, stdout=PIPE, stderr=PIPE, encoding="utf-8", stdin=PIPE)
    out = p.communicate(text)[0]
    
    with open(file_out, "r") as f:
        assert f.read() in out


def test_error_params():
    cmd = [PROG, "-e"]
    p = run(cmd, stdout=PIPE, stderr=PIPE, encoding="utf-8")
    assert "Not valid name" in p.stderr
