# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto --group-directories-first'
PS1='[\u@\h] [\w]\n\$ '
export visual='emacsclient'
export EDITOR='vim'
export LD_LIBRARY_PATH='/lib/openssl-1.0'

alias nvim="nvim -u ~/.nvimrc"

alias mpv="mpv --ao=jack"

# setxkbmap -layout us
alias keylayout="evince /run/media/martin/PornBank/ergodox/layout.pdf"

alias s="sudo"
alias p="sudo pacman"
alias q="exit"
alias r="source ranger"
alias v="vim"
alias y="yt-dlp"
alias e="emacsclient -cn"
alias k="killall"

alias update="sudo pacman -S archlinux-keyring && sudo pacman -Syu --noconfirm"
alias pls="sudo"

alias hdmiOn="xrandr --output HDMI-0 --mode 1920x1080 --right-of DVI-D-0 --rotate left"
alias hdmiOff="xrandr --output HDMI-0 --off"

alias cpass="pass -c websites/"

#TODO: make a python program that wraps rm and warns you
#      if you try to call rm *, rm /, or rm .
# alias rm="pyrm.py"

set -o vi
