" vim mapping of commands

" General Shortcuts {{{

" jk is escape
inoremap jk <esc>

"}}}

" Leader Shortcuts {{{

let mapleader="\<space>"

" go to next split
nnoremap <Leader>w <c-w>w

" Toggle nerd tree
nnoremap <Leader>n :NERDTreeToggle<CR>

" Turn off search highlighting
nnoremap <Leader>h :nohlsearch<CR>

" Reload vimrc
nnoremap <Leader>r :source ~/.vimrc<CR>

" space opens or closes folds
nnoremap <leader><space> za


"}}}
