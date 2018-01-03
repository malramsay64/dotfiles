#!/usr/bin/env bash

# bash aliases

alias cp='cp -iv'       # Confirm overwrite of file, list files on copying
alias mv='mv -iv'       # Confirm overwrite of file, list files on moving
alias la='ls -a'        # List hidden files
alias ll='ls -l'        # List in long form
alias mkdir='mkdir -pv' # Make all folders in path given, lists directories as they are created
if [[ -n "$BASH_VERSION" ]]; then
    alias ..='cd ..'
fi
if [[ $(uname) == "Darwin" ]]; then
    alias ls='ls -G'
    cd() { builtin cd "$@"; [[ $? == 0 ]] && ls -G ;}
else
    alias ls='ls --color=auto'
    cd() { builtin cd "$@"; [[ $? == 0 ]] && ls --color=auto ;}
fi

alias c='clear'
del() { mv "$@" ~/.Trash/ ;}  # Make use of the trash on command line
alias eject="hdiutil eject"   # will unmount and eject drives. useage eject /Volume/<drive>
alias rd='pushd +1'
alias ravp='rsync -av --progress'
alias rsync-ex='rsync -rltDvP'
alias grep='grep --color=AUTO'

# Conda aliases
alias sact='source activate'
alias sd='source deactivate'

# Git aliases
alias g='git'
#alias go='git checkout' # this collides with the golang command
#alias gc='git commit'
#alias gb='git branch'
#alias gd='git diff'
#alias ga='git add'
alias gs='git status' # This is so I don't keep starting ghostscript

# Function to revert all files to default permissions
defmod() {
    find "$1" -type d -exec chmod 755 {} \;
    find "$1" -type f -exec chmod 644 {} \;
}

# PBS aliases
if hash qstat 2>/dev/null; then
    alias qstatu='qstat | grep $USER'
    alias qdelall='qdel $(qstat -u $USER | grep ^[0-9] | cut -d. -f1 | tr "\n" " ")'
fi
