#!/usr/bin/env bash

echo "Installing dotfiles"

echo "Initialising submodule(s)"
git submodule update --init --recursive

echo "Make local directories"
mkdir -p "$HOME/.local/bin"

source "install/link.sh"

echo "Creating vim directories"
mkdir -p "$HOME/.vim-tmp/{swap,undo}"

echo "Installing vim plugins"
vim +PlugUpdate +qall

echo "Installing zsh config"
# Install and manage antibody
curl -sL https://git.io/antibody | sed 's/sudo //' | sed 's|/usr/local|$HOME/.local|' | bash -s
antibody bundle <"$DOTFILES/antibody/bundles.txt" >"$DOTFILES/zsh/sourceables.sh"
antibody update

echo "Installing pyenv"
if [ ! -d "$HOME/.pyenv" ]; then
    curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
fi
echo "Done!"
