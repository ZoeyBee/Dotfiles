#!/usr/bin/python3
from subprocess import call
from sys import argv

call(['ffmpeg', '-i', argv[1], '-ss', '00:00:00', '-to', '00:04:30', '-c', 'copy', '1.wav'])
call(['ffmpeg', '-i', argv[1], '-ss', '00:04:30', '-c', 'copy', '2.wav'])
