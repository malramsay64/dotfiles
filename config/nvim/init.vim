scriptencoding utf-8

command! -nargs=0 Reload source "$MYVIMRC"

call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/completion-treesitter'
Plug 'nvim-lua/completion-nvim'
Plug 'sainnhe/edge' " The colourscheme
Plug 'justinmk/vim-dirvish'
Plug 'wincent/corpus'
Plug 'SirVer/ultisnips' " support snippets
Plug 'honza/vim-snippets' " This contains the snippets
Plug 'itchyny/lightline.vim' " Status line
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive' 
Plug 'tpope/vim-repeat' " Repeat plugin commands
call plug#end()

colorscheme edge

let mapleader = "\<space>"

nnoremap <silent> <C-s> :call spelling#fix_previous()<CR>
inoremap <silent> <C-s> <C-g>u<C-o>:call spelling#fix_previous()<CR>

function! LuaComplete (ArgLeaf, CmdLine, CursorPos) abort
        return map(luaeval("vim.tbl_keys(" . a:CmdLine[4:] . ")"), {k,v -> a:CmdLine[4:] . "." . v})
endfunction

command! -complete=customlist,LuaComplete -nargs=1 LuaFile lua <args>

lua << EOF
require('init')
EOF
