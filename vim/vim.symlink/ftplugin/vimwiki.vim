" Vimwiki file specific settings
setlocal spell

" Prevent error from latex inline
highlight texOnlyMath ctermbg=None

" Remove buffer from autocomplete
let b:deoplete_ignore_sources = {}
let b:deoplete_ignore_sources._ = ['buffer']

"setlocal foldmethod=syntax
"let g:vimwiki_folding='list'
" Tell Vimwiki to let me decide manually
"let g:vimwiki_folding = ''

"" Default to Vimwiki's section folding options
"autocmd FileType vimwiki setlocal
      "\ fdm=expr
      "\ foldexpr=VimwikiFoldLevel(v:lnum)
      "\ foldtext=VimwikiFoldText()
