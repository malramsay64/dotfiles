" Configuration for Vundle package manager

" Automatic install vim-plug if not already
if empty(glob('~/dotfiles/vim/vim.symlink/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup pluginstall
      autocmd!
      autocmd VimEnter * PlugInstall | source $MYVIMRC
  augroup END
endif

" Helper function for neovim only plugins
function! Cond(cond, ...)
  let l:opts = get(a:000, 0, {})
  return a:cond ? l:opts : extend(l:opts, { 'on': [], 'for': [] })
endfunction

" Function to update remote plugins
function! DoRemote()
    UpdateRemotePlugins
endfunction

call plug#begin()

" Colourschemes
Plug 'tyrannicaltoucan/vim-quantum'

" Examine syntax highlighting rules
Plug 'gerw/vim-HiLinkTrace', { 'on': ['HLT', 'HLT!'] }

" Status bar
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'

" Syntax checking
Plug 'janko-m/vim-test'
Plug 'w0rp/ale'

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all --no-zsh --no-bash' }
Plug 'junegunn/fzf.vim'

" Filetype specific plugins
" Python
Plug 'fs111/pydoc.vim', { 'on': ['Pydoc', 'PydocSearch'] }
Plug 'lambdalisue/vim-cython-syntax'
Plug 'fisadev/vim-isort', Cond(executable('isort'), { 'for': ['python', 'cython'] })
Plug 'bps/vim-textobj-python', { 'for': ['python', 'cython'] }

" Other Languages
Plug 'sheerun/vim-polyglot'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': 'pandoc' }
Plug 'gu-fan/riv.vim'

" Autocomplete
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-github'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-ultisnips'
Plug 'ncm2/ncm2-markdown-subscope'
Plug 'ncm2/ncm2-rst-subscope'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'Shougo/echodoc.vim'

" Additional text-objects
Plug 'wellle/targets.vim'
Plug 'wvffle/vimterm'

" Writing plugins
let g:text_files = ['markdown', 'vimwiki', 'text', 'gitcommit', 'pandoc', 'rst']
Plug 'reedes/vim-litecorrect', { 'for': text_files }
Plug 'ChesleyTan/wordCount.vim', { 'for': text_files }
Plug 'reedes/vim-pencil', {'for': text_files }
Plug 'beloglazov/vim-online-thesaurus'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

" Search and replace
Plug 'haya14busa/incsearch.vim'         " Auto unhighlight search results
Plug 'wincent/scalpel'

" File Explorer

" General Plugins
Plug 'tpope/vim-fugitive'               " git integration
Plug 'tpope/vim-surround'               " surround text with characters
Plug 'tpope/vim-repeat'                 " repeat with plugins
Plug 'tpope/vim-unimpaired'             " complimentary mappings
Plug 'tpope/vim-speeddating'            " incr/decr dates
Plug 'tpope/vim-vinegar'                " Make netrw useable
Plug 'scrooloose/nerdcommenter'         " commenting code
Plug 'PeterRincker/vim-argumentative'   " manipulating function arguments
Plug 'airblade/vim-gitgutter'           " git diffs
Plug 'szw/vim-tags'                     " ctag support
Plug 'mbbill/undotree'                  " undo
Plug 'nixon/vim-vmath'                  " math on visual selections
Plug 'aperezdc/vim-template'            " Create templates for new files
Plug 'farmergreg/vim-lastplace'         " Remember last location in files
Plug 'godlygeek/tabular'                " Align bits of text
Plug 'majutsushi/tagbar'
Plug 'gioele/vim-autoswap'
Plug 'jez/vim-github-hub'
Plug 'kana/vim-textobj-user' " Custom text objects

Plug 'malramsay64/nvim-project-log', Cond(has('nvim'), { 'do': ':UpdateRemotePlugins' })

" all plugins must be added before this line
call plug#end()
