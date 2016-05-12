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

" Status bar
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Plugins
Plugin 'tpope/vim-fugitive'                 " git integration
Plugin 'tpope/vim-surround'                 " surround text with characters
Plugin 'tpope/vim-repeat'                   " repeat with plugins
Plugin 'scrooloose/nerdtree'                " file management
Plugin 'scrooloose/nerdcommenter'           " commenting code
Plugin 'scrooloose/syntastic'                " Syntax checking of code
Plugin 'octol/vim-cpp-enhanced-highlight'   " better c++ highlighting
Plugin 'Townk/vim-autoclose'                " autoclose delimeters

" all plugins must be added before this line
call vundle#end()
