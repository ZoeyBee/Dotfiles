#!/usr/bin/env python
# coding=utf-8

# python examples/my_hello.py --install --bin=myhello

from qutescript import userscript
import pyautogui as pag
import subprocess


FILEPATH = '/tmp/emacspaste'


@userscript
def hello_world(request):
    text = ''

    pag.keyDown('winleft')
    pag.press('3')
    pag.keyUp('winleft')

    with open(FILEPATH, 'w+') as f:
        process = subprocess.Popen(['emacsclient', FILEPATH])
        process.wait()
        text += f.read()

    pag.keyDown('winleft')
    pag.press('2')
    pag.keyUp('winleft')
    pag.press('i')
    pag.typewrite(text)
    pag.press('escape')


if __name__ == '__main__':
    hello_world()
