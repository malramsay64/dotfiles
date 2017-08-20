# A series of environment settings that should be present in whichever shell is being used

# Add italics to xterm
#if [ "$TERM" == xterm* ] && [ $(infocmp -1 "$TERM" | grep 'sitm') -ne "" ] ; then 
    #{ infocmp -1 "$TERM" ; echo -e "\tsitm=\\E[3m,\n\tritm=\\E[23m,"; } > "$HOME/dotfiles/resources/$TERM.terminfo"
    #tic "$HOME/dotfiles/resources/$TERM.terminfo"
#fi

# For homebrew
export PATH="/usr/local/bin:$PATH"

# Change settings for z
export _Z_DATA="$HOME/.z/z"
source "$HOME/dotfiles/bash/z/z.sh"

# Setting editor to nvim if present
if [ "$(hash nvr 2>/dev/null && echo 1)" ]; then
    export EDITOR="nvr --remote-silent"
elif [ "$(hash nvim 2>/dev/null && echo 1)" ]; then
    export EDITOR=nvim
elif [ -e "$HOME/.local/bin/vim" ]; then
    export EDITOR=$HOME/.local/bin/vim
else
    export EDITOR=vim
fi
# Editor aliases
alias v=$EDITOR

# Have consistent location for forwarded ssh authentication socket
if [[ "$SSH_AUTH_SOCK" == /tmp/* ]]; then
    ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/ssh-agent-sock"
    export SSH_AUTH_SOCK="$HOME/.ssh/ssh-agent-sock"
fi

# pyenv
if [ ! -d "$HOME/.pyenv" ]; then
    curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
fi
export PATH="/Users/malcolm/.pyenv/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# Adding home directory bin to path
[ -d "$HOME/dotfiles/bin" ] && export PATH="$PATH:$HOME/dotfiles/bin"
[ -d "$HOME/.bin" ] && export PATH="$HOME/.bin:$PATH"
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

# Test interactive shell
[[ $- == *i* ]] && stty -ixon
