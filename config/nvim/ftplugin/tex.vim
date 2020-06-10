" Latex specific settings for vim
setlocal spell

" Use 2 spaces as the tab width
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

call UltiSnipsAddFiletypes tex.plaintex

setlocal makeprg="latexmk -pdf -outdir=output "
