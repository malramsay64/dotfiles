#!/usr/bin/env bash

# Transparent aliases
#
# This is stuff that I don't really care about what it does, just that it works behind the scenes to
# make my life easier.

alias cp='cp -iv'       # Confirm overwrite of file, list files on copying
alias mv='mv -iv'       # Confirm overwrite of file, list files on moving
alias la='ls -a'        # List hidden files
alias ll='ls -l'        # List in long form
alias mkdir='mkdir -pv' # Make all folders in path given, lists directories as they are created

if [[ $(uname) == "Darwin" ]]; then
    alias ls='ls -G'
    cd() { builtin cd "$@"; [[ $? == 0 ]] && ls -G ;}
else
    alias ls='ls --color=auto'
    cd() { builtin cd "$@"; [[ $? == 0 ]] && ls --color=auto ;}
fi

alias grep='grep --color=AUTO'
alias c='clear'
del() { mv "$@" ~/.Trash/ ;}  # Make use of the trash on command line
alias eject="hdiutil eject"   # will unmount and eject drives. useage eject /Volume/<drive>


# Abbreviations
#
# These are aliases that I want replaced on the command line. These are mostly tools to make my life
# easier with fewer keystrokes. However, these I care about them showing up in the command line
# history.
#
# The abbreviations are not builtin, so we first have to write the functions to suport them.
# Functions adapted from http://www.math.cmu.edu/~gautam/sj/blog/20140625-zsh-expand-alias.html

typeset -a abbr
abbr=()

function abbr()
{
    alias $1
    abbr+=(${1%%\=*})
}

function expand-abbr()
{
    if [[ $LBUFFER =~ "\<(${(j:|:)abbr})\$" ]]; then
        zle _expand_abbr
        zle expand-word
    fi
    zle magic-space
}

zle -N expand-abbr

bindkey -M viins ' '        expand-abbr
bindkey -M viins '^ '       magic-space     # control-space to bypass completion
bindkey -M isearch " "      magic-space     # normal space during searches

abbr ravp='rsync -av --progress'
abbr rex='rsync -rltDvP'
abbr tmux='tmux'
abbr g='git'
abbr gap='git add -p'
abbr gst='git status'

# Cause I can never spell install correctly
abbr isntall='install'

# PBS aliases
if hash qstat 2>/dev/null; then
    abbr qs='qstat -Jt -u $USER'
    abbr qsu='qstat -u $USER'
    abbr qdelall='qdel $(qstat -u $USER | grep ^[0-9] | cut -d. -f1 | tr "\n" " ")'
fi


# Function to revert all files to default permissions
defmod() {
    find "$1" -type d -exec chmod 755 {} \;
    find "$1" -type f -exec chmod 644 {} \;
}

