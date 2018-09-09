import os
import sys
import ujson
from subprocess import Popen, PIPE, STDOUT, CalledProcessError


def parse(file):
    cmd = ['java', '-Xmx8G', '-jar',
           '../Parser/parser-main/target/parser-main-0.0.1-SNAPSHOT-jar-with-dependencies.jar']


    input = ujson.dumps(file)
    p = Popen(cmd, stdin=PIPE, stdout=PIPE, stderr=PIPE)
    stdout, stderr = p.communicate(input.encode("utf-8"))

    if p.returncode != 0:
        print("Status : FAIL", p.returncode)
        print("> " + " ".join(cmd))
        print(stderr)
    else:
        return ujson.loads(stdout)
