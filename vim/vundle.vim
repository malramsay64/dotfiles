" Configuration for Vundle package manager

set nocompatible
filetype off

" set runtime path to include vundle and initialise
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage vundle
Plugin 'VundleVim/Vundle.vim'

" Colourschemes
Plugin 'chriskempson/base16-vim'

" Plugins
Plugin 'tpope/vim-fugitive'         " git integration
Plugin 'tpope/vim-surround'         " surround text with characters


" all plugins must be added before this line
call vundle#end()
filetype plugin indent on
