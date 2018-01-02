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
if hash nvr 2>/dev/null; then
    export EDITOR="$(which nvr) --remote-silent"
elif hash nvim 2>/dev/null; then
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
elif [[ "$SSH_AUTH_SOCK" == /run/* ]]; then
    ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/ssh-agent-sock"
    export SSH_AUTH_SOCK="$HOME/.ssh/ssh-agent-sock"
fi

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

# Add conda to path
export PATH=$HOME/.miniconda/bin:$PATH

# Adding home directory bin to path
[ -d "$HOME/go/bin" ] && export PATH="$HOME/go/bin:$PATH"
[ -d "$HOME/.cargo/bin" ] && export PATH="$HOME/.cargo/bin:$PATH"
[ -d "$HOME/dotfiles/bin" ] && export PATH="$PATH:$HOME/dotfiles/bin"
[ -d "$HOME/.bin" ] && export PATH="$HOME/.bin:$PATH"
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

# Alias gopass, which provides nicer features to pass
if hash gopass 2> /dev/null; then
    alias pass="gopass"
fi

# Test interactive shell
[[ $- == *i* ]] && stty -ixon
