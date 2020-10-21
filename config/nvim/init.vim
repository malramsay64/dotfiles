scriptencoding utf-8

command! -nargs=0 Reload source "$MYVIMRC"

let s:vim_plug_file = glob(stdpath('config') . '/autoload/plug.vim')
if empty(s:vim_plug_file)
  silent !curl -fLo s:vim_plug_file --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup pluginstall
      autocmd!
      autocmd VimEnter * PlugInstall | source $MYVIMRC
  augroup END
endif

call plug#begin()
" Utility Plugins 
" Plugins that form dependencies for the main functionality I am looking for
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

" Colourscheme Plugins
Plug 'sainnhe/edge' 

" Language and Completion Plugins
" These are either plugins for parsing the language and colouring or
" alternatively for finding completions. This covers all aspects of the
" completions, including support for snippets.
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/completion-treesitter'
Plug 'nvim-lua/completion-nvim'
Plug 'SirVer/ultisnips'        " support snippets
Plug 'honza/vim-snippets'      " This contains the snippets

" Enhancing Vim
" A collection of plugins for enhancing the general behaviour of vim/neovim.
" These are specifically general plugins that work across the board.
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'        " Repeat plugin commands
Plug 'junegunn/vim-easy-align' " Align symbols within vim

" Utilities for Vim
" This provide tools for enhancing specific aspects of the vim experience,
" usually through an interface for a specific task.
Plug 'justinmk/vim-dirvish'
Plug 'wincent/corpus'
Plug 'itchyny/lightline.vim'   " Status line
Plug 'tpope/vim-fugitive' 
Plug 'nvim-lua/telescope.nvim' " Fuzzy finder
call plug#end()

colorscheme edge

let mapleader = "\<space>"

" nnoremap <silent> <C-s> :call spelling#fix_previous()<CR>
" inoremap <silent> <C-s> <C-g>u<C-o>:call spelling#fix_previous()<CR>

lua << EOF
require('init')
EOF
