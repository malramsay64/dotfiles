#!/usr/bin/env bash

echo "Installing dotfiles"

echo "Initialising submodule(s)"
git submodule update --init --recursive

echo "Make local directories"
mkdir -p "$HOME/.local/bin"

source "install/link.sh"

echo "Creating vim directories"
mkdir -p "$HOME/.vim-tmp/undo"
mkdir -p "$HOME/.vim-tmp/swap"

echo "Installing vim plugins"
vim +PlugUpdate +qall

echo "Installing zsh config"
# Install and manage antibody
curl -sL https://git.io/antibody | sed 's/sudo //' | sed 's|/usr/local|$HOME/.local|' | bash -s
antibody bundle <"$DOTFILES/zsh/plugins.txt" >"$DOTFILES/zsh/sourceables.sh"
antibody update

echo "Installing conda"
if [ ! -d $HOME/.miniconda ]; then
    if [ $(uname -s) == 'Darwin' ]; then
        curl https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -o ~/Downloads/miniconda.sh;
    else
        curl https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o ~/Downloads/miniconda.sh;
    fi
    bash ~/Downloads/miniconda.sh -b -u -p $HOME/.miniconda
    $HOME/.miniconda/bin/conda env create -f $DOTFILES/python/environment.yml
fi

echo "Done!"
