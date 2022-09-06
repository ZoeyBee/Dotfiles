#!/usr/bin/env python
# coding=utf-8

import pyautogui as pag
from time import sleep

width  = pag.size()[0] - 3
height = pag.size()[1]

pag.moveTo(width / 2, (height / 2) - 1); sleep(0.001); pag.moveRel((0, 1))
