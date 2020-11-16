scriptencoding utf-8

command! -nargs=0 Reload source "$MYVIMRC"

let mapleader = "\<space>"

" nnoremap <silent> <C-s> :call spelling#fix_previous()<CR>
" inoremap <silent> <C-s> <C-g>u<C-o>:call spelling#fix_previous()<CR>

lua << EOF
require('init')
EOF

colorscheme edge
