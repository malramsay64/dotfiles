" Configuration for Vundle package manager

" Automatic install vim-plug if not already
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Helper function for neovim only plugins
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Function to update remote plugins
function! DoRemote()
    UpdateRemotePlugins
endfunction

call plug#begin()

" Colourschemes
Plug 'chriskempson/base16-vim'
Plug 'rakr/vim-one'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Vim Wiki
Plug 'vimwiki/vimwiki'
Plug 'tbabej/taskwiki'

" Task warrior
Plug 'blindFS/vim-taskwarrior', Cond(system('hash task && echo 1'))

" Syntax checking
"Plug 'scrooloose/syntastic'
Plug 'neomake/neomake', { 'on': 'Neomake' }

" Filetype specific plugins
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp', 'c'] } " better c++ highlighting
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' } " pep8 indenting for python files
Plug 'lervag/vimtex', { 'for': 'tex' }  " Plugin for latex

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins<CR>'}

" Additional text-objects
Plug 'kana/vim-textobj-user'
Plug 'bps/vim-textobj-python'

Plug 'tpope/vim-fugitive'               " git integration
Plug 'tpope/vim-surround'               " surround text with characters
Plug 'tpope/vim-repeat'                 " repeat with plugins
Plug 'tpope/vim-unimpaired'             " complimentatry mappings
Plug 'scrooloose/nerdtree'              " file management
Plug 'scrooloose/nerdcommenter'         " commenting code
"Plug 'Townk/vim-autoclose'              " autoclose delimeters
Plug 'PeterRincker/vim-argumentative'   " manipulating function arguments
Plug 'airblade/vim-gitgutter'            " git diffs
Plug 'godlygeek/tabular', { 'on': 'Tabuarize'} " align text
Plug 'szw/vim-tags'                      " ctag support
Plug 'kien/ctrlp.vim'                   " fuzzy file finder


" all plugins must be added before this line
call plug#end()
