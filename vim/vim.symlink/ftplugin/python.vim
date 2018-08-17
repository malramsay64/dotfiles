augroup ftpython
    autocmd!
    autocmd BufWritePost <buffer> Isort
augroup END
set formatoptions-=t

setlocal spell

let b:ale_linters = ['pylint', 'mypy', 'pycodestyle', 'pydocstyle']
