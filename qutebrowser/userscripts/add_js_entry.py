#!/usr/bin/env python
# coding=utf-8

import os
from qutescript import userscript

@userscript
def add_entry(request):
    url = request.url
    url = url[:url[8:].find('/')+8]
    with open('Dotfiles/qutebrowser/javascript_whitelist.py', 'r+') as f:
        text = f.read()[:-2]
        text += f'    \'{url}\',\n]\n'
        f.seek(0)
        f.write(text)

if __name__ == '__main__':
    add_entry()
