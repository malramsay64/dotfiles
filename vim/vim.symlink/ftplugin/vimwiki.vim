" Vimwiki file specific settings
setlocal spell

" Prevent error from latex inline
highlight texOnlyMath ctermbg=None

" Remove buffer from autocomplete
let b:deoplete_ignore_sources = {}
let b:deoplete_ignore_sources._ = ['buffer']
