# Projekt: Prevod bezkontextové vlastní gramatiky (dále BKG) na bezkontextové gramatiky v Chomského normální formě
# Nazev: BKG-2-CNF
# Autor: Pavel Yadlouski (xyadlo00)
# Rok: 2021/2022

from . import PROG
from subprocess import check_output, run, PIPE


def test_correct_rules():
    file_in = "rules/correct.in"
    file_out = "rules/correct.out"
    cmd = [PROG, file_in, "-i"]
    out = check_output(cmd, encoding="utf=8")
    with open(file_out, "r") as f:
        assert f.read() in out


def test_rule_wrong_format():
    file_in = "rules/test_wrong_format.in"
    file_out = "rules/test_wrong_format.out"
    cmd = [PROG, file_in, "-i"]
    out = run(cmd, encoding="utf=8", stderr=PIPE, stdout=PIPE)
    with open(file_out, "r") as f:
        assert f.read() in out.stderr
