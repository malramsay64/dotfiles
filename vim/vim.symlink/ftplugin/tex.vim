" Latex specific settings for vim
setlocal spell

" Use 2 spaces as the tab width
set tabstop=2
set softtabstop=2
set shiftwidth=2

UltiSnipsAddFiletypes tex.plaintex

set makeprg="latexmk -pdf -outdir=output "

