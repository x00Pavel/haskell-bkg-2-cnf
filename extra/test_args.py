from subprocess import PIPE, STDOUT, Popen, run, CalledProcessError
from tabnanny import check

import pytest
from extra import PROG


def test_stdin(caplog, compile):
    cmd = [PROG]
    text = "some text"
    p = Popen(cmd, stdout=PIPE, stderr=PIPE, encoding="utf-8", stdin=PIPE)
    out = p.communicate(text)[0]
    assert text in out


@pytest.mark.parametrize('params', (["-i"],
                                    ["-1"],
                                    ["-2"],
                                    ["-1", "-i"],
                                    ["-1", "-i", "-2"]))
def test_stdin_with_params(params):
    cmd = [PROG, *params]
    text = "some text"
    p = Popen(cmd, stdout=PIPE, stderr=PIPE, encoding="utf-8", stdin=PIPE)
    out = p.communicate(text)[0]
    assert "Rading from STDIN"
    assert text in out


def test_error_params():
    cmd = [PROG, "-e"]
    p = run(cmd, stdout=PIPE, stderr=PIPE, encoding="utf-8")
    assert "Not valid name" in p.stderr
