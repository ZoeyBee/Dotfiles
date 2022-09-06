#!/usr/bin/python
from subprocess import call

path = '/tmp/latest_fullscrenshot.png'

call(['rm', path])
call(['scrot', path])
