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

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Vim Wiki
Plug 'vimwiki/vimwiki'
"Plug 'tbabej/taskwiki'

" Task warrior
Plug 'blindFS/vim-taskwarrior'

" Syntax checking
"Plug 'scrooloose/syntastic'
Plug 'neomake/neomake', { 'on': 'Neomake' }

" Autocomplete
Plug 'Shougo/deoplete.nvim', Cond(has('nvim'), { 'do': function('DoRemote') })

Plug 'tpope/vim-fugitive'               " git integration
Plug 'tpope/vim-surround'               " surround text with characters
Plug 'tpope/vim-repeat'                 " repeat with plugins
Plug 'tpope/vim-unimpaired'             " complimentatry mappings
"Plug 'scrooloose/nerdtree'              " file management
Plug 'scrooloose/nerdcommenter'         " commenting code
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp', 'c'] } " better c++ highlighting
"Plug 'Townk/vim-autoclose'              " autoclose delimeters
Plug 'PeterRincker/vim-argumentative'   " manipulating function arguments
Plug 'airblade/vim-gitgutter'            " git diffs
Plug 'godlygeek/tabular', { 'on': 'Tabuarize'} " align text

" all plugins must be added before this line
call plug#end()