augroup ftpython
    autocmd!
    autocmd BufWritePost *.py silent! execute "!black %" | redraw!
    autocmd BufWritePost *.py Isort
augroup END
set formatoptions-=t
