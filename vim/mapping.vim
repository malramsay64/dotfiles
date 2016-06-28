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
nnoremap <Leader>r :source $MYVIMRC<CR>
" Edit vimrc
nnoremap <Leader>er :e $MYVIMRC<CR>
" Edit vim folder
nnoremap <Leader>ef :e $HOME/dotfiles/vim<CR>

" space opens or closes folds
nnoremap <leader><space> za

" next and previous in location list
nnoremap <leader>o :lnext<CR>
nnoremap <leader>p :lprev<CR>

" Quick spell fix
nnoremap <leader>s 1z=


"}}}
