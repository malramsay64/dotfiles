
# For homebrew
export PATH=/usr/local/bin:$PATH

# Setting editor to nvim if present
if [[ $(hash nvim 2>/dev/null && echo 1) ]]; then
    export EDITOR=nvim
elif [[ -e $HOME/.local/bin/vim ]]; then
    export EDITOR=$HOME/.local/bin/vim
else
    export EDITOR=vim
fi

# Adding home directory bin to path
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/dotfiles/bin"

