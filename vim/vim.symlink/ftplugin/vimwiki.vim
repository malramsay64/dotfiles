" Vimwiki file specific settings
setlocal spell

" Prevent error from latex inline
highlight texOnlyMath ctermbg=None

" Remove buffer from autocomplete
let b:deoplete#ignore_sources = {}
let b:deoplete#ignore_sources._ = ['buffer']
