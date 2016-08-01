highlight ColumnLimit ctermbg=08
augroup LongLines
    autocmd!
    autocmd FileType * match none
    autocmd FileType python match ColumnLimit /\%80v.\+/
augroup END

