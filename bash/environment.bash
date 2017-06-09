# A series of environment settings that should be present in whichever shell is being used

# Add italics to the current term
{ infocmp -1 $TERM ; echo -e "\tsitm=\\E[3m,\n\tritm=\\E[23m,"; } > ~/dotfiles/resources/$TERM.terminfo
tic ~/dotfiles/resources/$TERM.terminfo

# For homebrew
export PATH=/usr/local/bin:$PATH

# Change settings for z
export _Z_DATA=$HOME/.z/z
source $HOME/dotfiles/bash/z/z.sh

# Setting editor to nvim if present
if [ $(hash nvim 2>/dev/null && echo 1) ]; then
    export EDITOR=nvim
elif [ -e $HOME/.local/bin/vim ]; then
    export EDITOR=$HOME/.local/bin/vim
else
    export EDITOR=vim
fi

# Adding home directory bin to path
[ -d "$HOME/dotfiles/bin" ] && export PATH="$PATH:$HOME/dotfiles/bin"
[ -d "$HOME/.bin" ] && export PATH="$HOME/.bin:$PATH"
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

# Test interactive shell
[[ $- == *i* ]] && stty -ixon
