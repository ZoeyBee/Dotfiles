#!/usr/bin/env python
# coding=utf-8

import sys
from subprocess import call
from os import path

temp_dir   = '/run/media/tmp'
iso_file   = sys.argv[1]
target_dir = sys.argv[2]

if not path.isdir(target_dir):
    call(['mkdir', target_dir])

call(['sudo', 'mkdir', temp_dir])
call(['sudo', 'mount', iso_file, temp_dir])
call(['cp', '-rv', temp_dir, target_dir])
call(['sudo', 'umount', temp_dir])
call(['sudo', 'rmdir', temp_dir])

