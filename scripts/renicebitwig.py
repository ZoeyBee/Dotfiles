#!/usr/bin/env python
# coding=utf-8

from subprocess import call, check_output

nice = -11

process_names = ['BitwigStudio']
processes = check_output(['ps', '-ef']).decode('utf-8')
process_names.append('Bitwig' + processes.split('Bitwig')[2].split(' ')[0])
process_names.append('Bitwig' + processes.split('Bitwig')[3].split(' ')[0])
for name in processes: call(['renice', '-n', nice, '-p', int(check_output(['pidof', name]))])
