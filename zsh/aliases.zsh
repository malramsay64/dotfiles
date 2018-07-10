#!/usr/bin/env zsh

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
    if [[ $LBUFFER =~ "(^|[;|&])\s*(${(j:|:)abbr})\$" ]]; then
        zle _expand_alias
    fi
    zle magic-space
}

zle -N expand-abbr

bindkey -M viins ' '        expand-abbr
bindkey -M viins '^ '       magic-space     # control-space to bypass completion
bindkey -M isearch " "      magic-space     # normal space during searches

# Function to revert all files to default permissions
defmod() {
    find "$1" -type d -exec chmod 755 {} \;
    find "$1" -type f -exec chmod 644 {} \;
}

