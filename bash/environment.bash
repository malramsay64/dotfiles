# A series of environment settings that should be present in whichever shell is being used

# Update path variable
function _add_to_path() {
    if [ -d "$1" ]; then
        export PATH="$1:$PATH"
    fi
}

function _source_file {
    if [ -f "$1" ]; then
        source "$1"
    fi
}

_add_to_path "$HOME/go/bin"
_add_to_path "$HOME/.cargo/bin"
_add_to_path "$HOME/dotfiles/bin"
_add_to_path "$HOME/.bin"
_add_to_path "$HOME/.local/bin"
_add_to_path "/usr/local/bin"

# Change settings for z
export _Z_DATA="$HOME/.z/z"
_source_file "$HOME/dotfiles/bash/z/z.sh"

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
# Read --help as manpage when no manpage exists
man() {
    /usr/bin/man $1 || nvim "+read! $1 --help" '+setlocal ft=man bt=nofile bufhidden=wipe noswapfile ro'
}

# Alias hub if present
if hash hub &>/dev/null; then
    eval "$(hub alias -s)"
fi

# Allow conda to activate environments (conda 4.4)
_source_file "$HOME/.miniconda/etc/profile.d/conda.sh"

# Alias gopass, which provides nicer features to pass
if hash gopass 2> /dev/null; then
    alias pass="gopass"
fi

# Test interactive shell
[[ $- == *i* ]] && stty -ixon
