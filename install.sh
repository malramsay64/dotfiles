#!/usr/bin/env bash

echo "Installing dotfiles"

#echo "Initialising submodule(s)"
#git submodule update --init --recursive

source "install/link.sh"

echo "Creating vim directories"
mkdir -p "$HOME/.vim-tmp"

echo "Installing vim plugins"
vim +PluginInstall +qall

echo "Done!"
