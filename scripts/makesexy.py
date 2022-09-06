#!/usr/bin/env python
# coding=utf-8

import os
import json

from time import sleep
from pathlib import Path
from contextlib import suppress
from threading import Thread
from subprocess import Popen, call
from sys import argv

home = str(Path.home()) + '/'
commands = [['xwinwrap', '-s', '-ov', '-fs', '-g', 'w=3840x1080+0+0', '-ni', '--',
             'nice', '-n', '19', 'mpv', '-wid', 'WID', f'{home}bg/bg.mp4', '-loop']]
pids = [None, None]
pids_file = '/tmp/isSexy.json'
already_sexy = False
on_off = 'on'

if os.path.isfile(pids_file):
    with open(pids_file, 'r') as f:
        pids = json.loads(f.read())
        on_off = 'off'
        already_sexy = True

if len(argv) > 1:
    on_off = argv[1]

def run_command(command, command_index):
    with open(os.devnull, 'r+b', 0) as DEVNULL:
        # p = Popen(command, stdin=DEVNULL, stdout=DEVNULL, stderr=DEVNULL, preexec_fn=os.setpgrp)
        p = Popen(command, stdin=DEVNULL, preexec_fn=os.setpgrp)
    set_pid(command_index, p.pid)

def set_pid(command, pid):
    pids[command] = pid

if on_off == 'off':
    call(['rm', pids_file])
    for pid in pids:
        call(['kill', str(pid)])

elif not already_sexy:
    for i, command in enumerate(commands):
        Thread(target=run_command, args=[command, i]).start()

    sleep(0.1)
    with open(pids_file, 'w+') as f:
        pids = json.dumps(pids)
        f.write(pids)
