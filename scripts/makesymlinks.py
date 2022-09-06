#!/usr/bin/env python
# coding=utf-8

'''
Removes old files and makes symlinks
'''

from subprocess import call
from os import listdir
from pathlib import Path

HOME    = str(Path.home()) + '/'
REPODIR = 'Dotfiles/'
DEBUG   = False


def link(source, dest):
    remove = ['rm', '-rf', HOME + dest]
    link   = ['ln', '-s', HOME + REPODIR + source, HOME + dest]

    if DEBUG:
        print(remove)
        print(link)
    else:
        call(remove)
        call(link)


# i3
link('i3wm/.i3rc', '.config/i3/config')
link('i3wm/compton.conf', '.config/compton.conf')
link('.bashrc', '.bashrc')

# scripts
for script in listdir(HOME + REPODIR + 'scripts'):
    if script != '__init__.py':
        link('scripts/' + script, script)

# emacs
link('emacs/.emacs', '.emacs')

# qutebrowser
link('qutebrowser', '.config/qutebrowser')

# qutebrowser
link('termite', '.config/termite')

# transmission
link('transmission/settings.json', '.config/transmission/settings.json')

# ranger
link('ranger', '.config/ranger')

# rofi
link('rofi/config', '.config/rofi/config')

# polybar
link('polybar/run_polybar.sh', 'run_polybar.sh')
link('polybar/.polybar', '.polybar')

# vim
link('vim/.vimrc', '.vimrc')
link('vim/.nvimrc', '.nvimrc')
