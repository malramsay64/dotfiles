augroup ftpython
    autocmd!
    autocmd BufWritePost *.py Isort
augroup END
set formatoptions-=t
