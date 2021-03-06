# Projekt: Prevod bezkontextové vlastní gramatiky (dále BKG) na bezkontextové gramatiky v Chomského normální formě
# Nazev: BKG-2-CNF
# Autor: Pavel Yadlouski (xyadlo00)
# Rok: 2021/2022

import pytest
from extra import PROG
from subprocess import PIPE, run
from .conftest import all_test_in


@pytest.mark.parametrize("file_name", all_test_in("headers"))
def test_wrong_header(file_name):
    cmd = [PROG, file_name, "-i"]
    p = run(cmd, encoding="utf-8", stdout=PIPE, stderr=PIPE)
    assert "Wrong header" in p.stderr
    assert p.returncode != 0
