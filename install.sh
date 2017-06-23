#!/usr/bin/env bash

echo "Installing dotfiles"

echo "Initialising submodule(s)"
git submodule update --init --recursive

source "install/link.sh"

echo "Creating vim directories"
mkdir -p "$HOME/.vim-tmp"
[ -d vim/vim.symlink/bundle/Vundle.vim ] || git clone https://github.com/VundleVim/Vundle.vim.git vim/vim.symlink/bundle/Vundle.vim

echo "Installing vim plugins"
vim +PlugUpdate +qall

echo "Done!"
