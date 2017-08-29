

" Setup mapping of commands
call denite#custom#map('insert', '<Esc>', '<denite:enter_mode:normal>', 'noremap')
call denite#custom#map('normal', '<Esc>', '<denite:quit>', 'noremap')
call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map('normal', '<C-v>', '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map('insert', '<C-h>', '<denite:do_action:split>', 'noremap')
call denite#custom#map('normal', '<C-h>', '<denite:do_action:split>', 'noremap')
call denite#custom#map('normal', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('normal', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('normal', 'a', '<denite:do_action:add>', 'noremap')
call denite#custom#map('normal', 'd','<denite:do_action:delete>','noremap')
call denite#custom#map('normal', 'r', '<denite:do_action:reset>', 'noremap')
call denite#custom#map('normal', 'cc', '<denite:do_action:commit>', 'noremap')
call denite#custom#map('normal', 'v', '<denite:do_action:vsplit>', 'noremap')


call denite#custom#option('_', 'highlight_mode_insert', 'None')
call denite#custom#option('_', 'highlight_matched_range', 'Underlined')
call denite#custom#option('_', 'highlight_matched_char', 'Search')
call denite#custom#option('default', {'mode': 'normal', 'auto_resize': 1})



" File rec {{{
" Setup ripgrep for file_rec command

call denite#custom#var('file_rec', 'command',
    \ ['rg', '--files', '--glob', '!.git', ''])
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
    \ ['--hidden', '--vimgrep', '--no-heading', '-S'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

call denite#custom#source('file_rec', 'sorters', ['sorter_sublime'])


"nnoremap <Leader>n :<C-u>Denite file_rec -mode=insert<CR>
nnoremap <leader>b :<C-U>Denite buffer<CR>

" }}}
" Menus code{{{

let s:menus = {}
let s:menus.Shell = { 'description': 'Edit shell commands'}
let s:menus.Shell.file_candidates = [
        \ ['~/.zshrc', '~/.zshrc'], 
        \ ['~/.zshenv', '~/.zshenv'], 
        \ ['~/dotfiles/zsh/prompt.zsh', '~/dotfiles/zsh/prompt.zsh'], 
        \ ['~/.bashrc.local', '~/.bashrc.local'], 
        \ ['~/dotfiles/bash/aliases.bash', '~/dotfiles/bash/aliases.bash'], 
        \ ['~/dotfiles/bash/environment.bash', '~/dotfiles/bash/environment.bash'], 
        \ ['~/dotfiles/bash/prompt.bash', '~/dotfiles/bash/prompt.bash'], 
        \ ['~/.bashrc', '~/.bashrc'], 
        \ ['alacritty', '~/.config/alacritty/alacritty.yml'],
    \]
let s:menus.Vim = { 'description': 'Edit Vim setup' }
let s:menus.Vim.file_candidates = [
        \ ['~/.vimrc','~/.vimrc'],
        \ ['~/dotfiles/vim/plugins.vim','~/dotfiles/vim/plugins.vim'],
        \ ['~/dotfiles/vim/denite.vim','~/dotfiles/vim/denite.vim'],
        \ ['~/dotfiles/vim/vim.symlink/plugged','~/dotfiles/vim/vim.symlink/plugged'],
    \]
let s:menus.ssh = { 'description': 'Edit ssh configuration' }
let s:menus.ssh.file_candidates = [ 
        \ ['~/.ssh/config','~/.ssh/config'],
        \ ['~/.ssh/known_hosts','~/.ssh/known_hosts'],
        \ ['~/.ssh/authorized_keys','~/.ssh/authorized_keys'],
    \]
let s:menus.tmux = { 'description': 'Edit tmux configuration' }
let s:menus.tmux.file_candidates = [ 
        \ ['~/.tmux.conf','~/dotfiles/tmux/tmux.conf.symlink'],
        \ ['tmux theme','~/dotfiles/tmux/theme.sh'],
    \]

call denite#custom#var('menu', 'menus', s:menus)
"call denite#custom#var('menu', 'buffer_name', 'menu')
nnoremap <Leader>e :<C-u>Denite menu <CR>

" }}}
" git {{{
"
call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
    \ ['git', 'ls-files', '-co', '--exclude-standard'])
nnoremap <silent> <C-p> :<C-u>Denite file_rec/git -mode=insert<CR>

call denite#custom#option('git', {'mode': 'normal', 'auto_resize': 1})

nnoremap <leader>gs :<C-u>DeniteBufferDir gitstatus -buffer-name=git<CR>
nnoremap <leader>gc :Gcommit<CR>

" }}}
" citation {{{
"
"nnoremap <Leader>c :<C-u>Unite citation/combined -buffer-name=citation -highlight-mode-insert='None'<CR>
nnoremap <silent><Leader>c :<C-u>Denite -buffer-name=citation -mode=insert -default-action=append Unite:citation/key<cr>
nnoremap <silent><Leader>co :<C-u>Unite -input=<C-R><C-W> -default-action=start -force-immediately citation/file<cr>
nnoremap <silent><Leader>ct :<C-u>Denite -buffer-name=citation -default-action=append unite:citation/key<cr>

let g:unite_source_line_enable_highlight=1
" }}}
