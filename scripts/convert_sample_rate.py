#!/usr/bin/python3
from sys import argv
from pathlib import Path
from subprocess import call

file_paths = argv[1]
if len(argv) > 1:
    file_paths = argv[1:]
samplerate = '48000'
# print(file_paths)
for file_path in file_paths:
    call(['ffmpeg', '-i', file_path, '-ar', samplerate, '9' + file_path + '_converted.wav'])
