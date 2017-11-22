# A series of environment settings that should be present in whichever shell is being used

# For homebrew
export PATH="/usr/local/bin:$PATH"

# Change settings for z
export _Z_DATA="$HOME/.z/z"
source "$HOME/dotfiles/bash/z/z.sh"

# histdb alias
function hist {
    histdb $1 --host
}

# Setting editor to nvim if present
if [ "$(hash nvr 2>/dev/null && echo 1)" ]; then
    export EDITOR="$(which nvr) --remote-silent"
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

# Install pyenv if not already installed
export PATH="$HOME/.pyenv/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

__pyenv_started=0

__pyenv_init() {
    test $__pyenv_started = 0 && {
        eval "$(command pyenv init -)"
        eval "$(command pyenv virtualenv init -)"
    __pyenv_started=1
}
}

pyenv() {
    __pyenv_init
    command pyenv "$@"
}

# use neovim/vim as manpager
if hash nvim &>/dev/null; then
    export MANPAGER="nvim +'set ft:man' -"
else
    export MANPAGER="vim +'set ft:man' -"
fi

# Alias hub if present
if hash hub &>/dev/null; then
    eval "$(hub alias -s)"
fi

# Adding home directory bin to path
[ -d "$HOME/dotfiles/bin" ] && export PATH="$PATH:$HOME/dotfiles/bin"
[ -d "$HOME/.bin" ] && export PATH="$HOME/.bin:$PATH"
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

# added by travis gem
[ -f /Users/malcolm/.travis/travis.sh ] && source /Users/malcolm/.travis/travis.sh

# Test interactive shell
[[ $- == *i* ]] && stty -ixon
