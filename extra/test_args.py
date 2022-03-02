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


@pytest.mark.skip("Look at me when more implementation of the args would be done")
@pytest.mark.parametrize('params', (["-i"],
                                    ["-1"],
                                    ["-1", "-i"],))
                                    # ["-2"],
                                    # ["-1", "-i", "-2"]))
def test_stdin_with_params(params):
    cmd = [PROG, *params]
    text = "some text"
    p = Popen(cmd, stdout=PIPE, stderr=PIPE, encoding="utf-8", stdin=PIPE)
    out = p.communicate(text)[0]
    assert text in out


def test_error_params():
    cmd = [PROG, "-e"]
    p = run(cmd, stdout=PIPE, stderr=PIPE, encoding="utf-8")
    assert "Not valid name" in p.stderr
