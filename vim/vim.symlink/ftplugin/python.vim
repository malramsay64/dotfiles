augroup pythonFiles
    autocmd!
    autocmd! BufEnter <buffer> match overLength /\%80v.\+/
augroup END
