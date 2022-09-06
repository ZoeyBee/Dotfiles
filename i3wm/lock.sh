#!/bin/bash
ICON=$HOME/.xlock/icon.png
TMPBG=/tmp/screen.png
scrot $TMPBG
convert $TMPBG  -scale 10% -background black -vignette 100x900 -radial-blur 0x8 -scale 1000% -blur 4x4 $TMPBG
convert $TMPBG $ICON -gravity center -composite -matte $TMPBG
i3lock -u -i $TMPBG
rm $TMPBG
