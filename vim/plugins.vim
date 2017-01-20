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
Plug 'rakr/vim-one'
Plug 'gerw/vim-HiLinkTracel', { 'on': ['HLT', HLT!] } " Examing syntax highlighting rules

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Vim Wiki
Plug 'vimwiki/vimwiki'

" Task warrior
Plug 'blindFS/vim-taskwarrior', Cond(system('hash task && echo 1'))

" Syntax checking
Plug 'neomake/neomake'

" Filetype specific plugins
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp', 'c'] } " better c++ highlighting
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' } " pep8 indenting for python files
Plug 'lervag/vimtex', { 'for': 'tex' }  " Plugin for latex
Plug 'lumiliet/vim-twig', { 'for': 'twig' }
Plug 'saltstack/salt-vim', { 'for': ['sls', 'saltstack'] }
Plug 'dearrrfish/vim-applescript', { 'for': 'applescript' }

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'davidhalter/jedi', { 'for': 'python' }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'Rip-Rip/clang_complete', { 'for': ['cpp', 'c'] }
Plug 'Shougo/echodoc.vim'

" Additional text-objects
Plug 'kana/vim-textobj-user'
Plug 'bps/vim-textobj-python'

" File management
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeFind', 'NERDTreeToggle'] }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': ['NERDTreeFind', 'NERDTreeToggle'] }


" Writing plugins
Plug 'reedes/vim-pencil', { 'for': ['markdown', 'vimwiki', 'text'] }
Plug 'reedes/vim-litecorrect', { 'for': ['markdown', 'vimwiki', 'text'] }

Plug 'tpope/vim-fugitive'               " git integration
Plug 'tpope/vim-surround'               " surround text with characters
Plug 'tpope/vim-repeat'                 " repeat with plugins
Plug 'tpope/vim-unimpaired'             " complimentatry mappings
Plug 'scrooloose/nerdcommenter'         " commenting code
Plug 'PeterRincker/vim-argumentative'   " manipulating function arguments
Plug 'airblade/vim-gitgutter'            " git diffs
Plug 'szw/vim-tags'                      " ctag support
Plug 'kien/ctrlp.vim'                   " fuzzy file finder
Plug 'mbbill/undotree'                  " undo
Plug 'nixon/vim-vmath'                  " math on visual selections
Plug 'haya14busa/incsearch.vim'


" all plugins must be added before this line
call plug#end()
