function spelling#fix_previous()
    " Get absolute cursor position
    let l:save_cursor = getpos('.')
    " Get cursor position from end of line
    let l:cur_col = col("$") - col(".")
    " Save undo state
    normal! <C-g>u
    " Correct spelling error
    normal! [s1z=
    " create another undo state
    normal! <C-g>u
    " Return to position relative to end of line
    let l:save_cursor[2] = col("$") - l:cur_col
    " Return cursor to previous position
    call setpos('.', l:save_cursor)
endfunction
