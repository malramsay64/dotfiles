#!/usr/bin/env zsh

# Transparent aliases
#
# This is stuff that I don't really care about what it does, just that it works behind the scenes to
# make my life easier.

# Colour in ls prompt and ls on cd
if [[ $(uname) == "Darwin" ]]; then
    alias ls='ls -G'
    cd() { builtin cd "$@"; [[ $? == 0 ]] && ls -G ;}
else
    alias ls='ls --color=auto'
    cd() { builtin cd "$@"; [[ $? == 0 ]] && ls --color=auto ;}
fi

# Use exa instead of ls when it is available
if type exa > /dev/null; then
    alias ls='exa'
    cd() { builtin cd "$@"; [[ $? == 0 ]] && exa ;}
fi


alias cp='cp -iv'       # Confirm overwrite of file, list files on copying
alias mv='mv -iv'       # Confirm overwrite of file, list files on moving
alias la='ls -a'        # List hidden files
alias ll='ls -l'        # List in long form
alias mkdir='mkdir -pv' # Make all folders in path given, lists directories as they are created
# Configure dd to work nicely with some default options
alias dd='dd status=progress conv=sync bs=1M'

alias grep='grep --color=AUTO'
alias c='clear'
del() { mv "$@" ~/.Trash/ ;}  # Make use of the trash on command line
alias eject="hdiutil eject"   # will unmount and eject drives. useage eject /Volume/<drive>

if type hub > /dev/null; then
    alias git='hub'
fi
if type gopass > /dev/null; then
    alias pass='gopass'
fi
if type gpg2 > /dev/null; then
    alias gpg='gpg2'
fi
if type neomutt > /dev/null; then
    alias mutt='neomutt'
fi
alias mux='tmuxinator'
