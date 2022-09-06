#!/usr/bin/python3
import os
import sys
from pathlib import Path
from subprocess import check_output, call

file_paths = sys.argv[1]
if len(sys.argv) > 1:
    file_paths = sys.argv[1:]

for file_path in file_paths:
    file_path = Path(file_path)
    key = check_output(['keyfinder-cli', file_path.as_posix()]).decode('utf-8')[:-1]
    new_file_name = (key + ' ' + file_path.name)
    call(['mv', file_path, new_file_name])

