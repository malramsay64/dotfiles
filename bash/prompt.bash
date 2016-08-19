#!/usr/bin/env bash

# Bash prompt settings

source $HOME/dotfiles/bash/colours.bash

Time="\A"
Hostname="\h"
ShortPath="\W"

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    # Connected via ssh
    host_colour=$Red
else
    host_colour=$Purple
fi

#GIT_PROMPT_DIR=$HOME/Setup/Bash/bash-git-prompt
if [ -f "$GIT_PROMPT_DIR/gitprompt.sh" ]; then
    export GIT_PROMPT_THEME=Malcolm
    source "$GIT_PROMPT_DIR/gitprompt.sh"
else
    PS1="${Time} ${host_colour}${Hostname} ${Green}${ShortPath} ${NC}$ "
fi
