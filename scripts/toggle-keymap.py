#!/usr/bin/env python
# coding=utf-8

from sh import setxkbmap

layout = setxkbmap('-query').split()[5]

if   layout == 'us': setxkbmap('-layout', 'no')
elif layout == 'no': setxkbmap('-layout', 'us')
