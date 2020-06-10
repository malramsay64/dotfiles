" fzf {{{
"
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'belowright 10split enew' }

" Customize fzf colours to match your colour scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

nnoremap <silent> <C-p> :<C-u>GFiles<CR>
nnoremap <silent> <C-f> :<C-u>Files<CR>
nnoremap <space>gf :<C-u>Commits<CR>
nnoremap <space>b :<C-U>Buffers<CR>

" }}}
" fugitive {{{

nnoremap <space>gs :Gstatus<CR>
nnoremap <space>gc :Gcommit<CR>

" }}}
" ale {{{

let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

let g:ale_linter_aliases = {'pandoc': ['markdown']}

let g:ale_linters = {
      \ 'python': ['flake8', 'mypy', 'pydocstyle'],
      \ 'c++': ['clangd'],
      \ 'cpp': ['clangd'],
      \ 'c': ['clangd'],
      \ 'rust': ['cargo'],
      \ 'markdown': ['textlint', 'mdl', 'alex'],
      \ }

let g:ale_rust_check_all_targets = 1
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
let g:ale_rust_cargo_clippy_options = '--all-features'


let g:ale_python_pylint_change_directory = 0
let g:ale_lint_on_text_changed = 1
let g:ale_lint_delay = 500
let g:ale_lint_on_save = 1

let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'python': ['isort', 'black'],
      \ 'yaml': ['prettier', 'remove_trailing_lines', 'trim_whitespace'],
      \ 'markdown': ['prettier', 'remove_trailing_lines', 'trim_whitespace'],
      \ 'cpp': ['clang-format', 'remove_trailing_lines', 'trim_whitespace'],
      \ 'rust': ['rustfmt'],
      \ }

let g:ale_fix_on_save = 1

nnoremap ]v :ALENextWrap<CR>
nnoremap [v :ALEPreviousWrap<CR>

" }}}
" ultisnips {{{

let g:UltiSnipsExpandTrigger='<C-f>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<S-tab>'
let g:UltiSnipsEditSplit='horizontal'

" Set the documentation style for the snippets
let g:ultisnips_python_style='google'

" Configuration settings
let g:snips_author = 'Malcolm Ramsay'
let g:snips_email = 'malramsay64@gmail.com'
let g:snips_github = 'https://github.com/malramsay64'

" Directories
let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'

" }}}
" vimtex {{{

let g:tex_flavor='latex'

" enable vimtex
let g:vimtex_enabled = 1

" Folding options
let g:vimtex_fold_enabled = 1
let g:vimtex_fold_env_whitelist = ['figure', 'table']

" latexmk options
let g:vimtex_latexmk_enabled = 1
let g:vimtex_latexmk_build_dir = 'output'

" }}}
" incsearch {{{

set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" }}}
" grammarous {{{

let g:grammarous#use_vim_spelllang = 1
let g:grammarous#move_to_first_error = 0
let g:grammarous#default_lang = 'en_au'

nnoremap <space>gg :GrammarousCheck<CR>
nnoremap <space>gr :GrammarousReset<CR>

" }}}
" template {{{

let g:templates_directory = [$DOTFILES.'/vim/templates']

let g:templates_user_variables = [
            \ ['DIRECTORY', 'GetDirectoryName'],
            \ ]

function! GetDirectoryName()
    " Expand to full path, remove the filename, then get the folder
    return expand('%:p:h:t')
endfunction

" }}}
" thesaurus_query {{{

nnoremap <space>y :ThesaurusQueryReplaceCurrentWord<CR>

" }}}
" undotree {{{

noremap <space>u :UndotreeToggle<CR>

" }}}
"  Scalpel {{{

nmap <space>s <Plug>(Scalpel)

"  }}}
" project-log {{{

let g:project_home = $HOME.'/Projects/'
let g:project_log#logbooks = [
            \ g:project_home.'Dynamics/logbook',
            \ g:project_home.'Crystal_Melting/logbook',
            \ g:project_home.'Machine_Learning/logbook',
            \ g:project_home.'Seminars',
            \ $HOME.'/Documents/diary'
            \ ]
let g:project_log#log_level = 'DEBUG'

"}}}
" pandoc {{{

let g:pandoc#syntax#conceal#use = 1
let g:pandoc#syntax#conceal#urls = 1
let g:pandoc#syntax#codeblocks#embeds#langs = ["python", "rust"]
let g:pandoc#modules#disabled = ["chdir", "folding", "keyboard", "formatting"]
let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#filetypes#pandoc_markdown = 1
let g:pandoc#formatting#mode='ha'
let g:pandoc#hypertext#open_editable_alternates=1
let g:pandoc#hypertext#use_default_mappings = 1
let g:pandoc#command#autoexec_command = "Pandoc! pdf"

let g:pandoc#biblio#bibs = [$HOME."/Downloads/PhD.bib"]
let g:pandoc#biblio#use_bibtool = 1

" }}}
" lightline {{{
"
" Configuration for ale
let g:lightline = {}

let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c "

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }
let g:lightline.component_function = {
      \   'gitbranch': 'fugitive#head',
      \   'wordcount': 'wordCount#WordCount',
      \ }
let g:lightline.component =  {
      \   'lineinfo': '%3l %-2v',
      \ }

let g:lightline.colorscheme  = 'quantum'
let g:lightline.active = {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
      \             [ 'lineinfo' ], [ 'wordcount', 'percent' ], [ 'filetype', 'fileformat' ] ]
      \ }

" }}}
" wordcount {{{

let g:wc_conservative_update = 1

"  }}}
" nerdcommenter {{{

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

nnoremap <C-/> <plug>NERDCommenterToggle
vnoremap <C-/> <plug>NERDCommenterToggle

" }}}
" Goyo {{{
"
let g:goyo_width=88

function! s:goyo_enter()
  ALEDisableBuffer
  let b:ale_fix_on_save = 0
  call lightline#disable()
  set noshowmode
  set noshowcmd
  set scrolloff=999
  if has('nvim')
      call ncm2#disable_for_buffer()
  endif
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z; or tmux resize-pane -Z
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z; and tmux resize-pane -Z
  call lightline#enable()
  set showmode
  set showcmd
  set scrolloff=5
  ALEEnableBuffer
  let b:ale_fix_on_save = 1
  if has('nvim')
      call ncm2#enable_for_buffer()
  endif
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

nnoremap <space>gg :Goyo<CR>

" }}}
" netrw {{{

let g:netrw_banner = 0

" }}}
" Polyglot  {{{
let g:python_highlight_all = 1

let g:polyglot_disabled = ['markdown']

" }}}
" ncm2 {{{

set completeopt=noinsert,menuone,noselect

let g:ncm2#matcher = 'substrfuzzy'

" Increse the delay before the popup appears
let g:ncm2#popup_delat = 250

augroup ncm2
  autocmd!
  autocmd BufRead * call ncm2#enable_for_buffer()
augroup END

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

let g:ncm2_pyclang#library_path = '/usr/lib64/libclang.so.7'
" a list of relative paths looking for .clang_complete
let g:ncm2_pyclang#args_file_path = ['.clang_complete']
let g:ncm2_pyclang#clang_path = 'clang++'

call ncm2#override_source('LanguageClient_cpp', {'enable': 0})

let g:float_preview#docked = 1

let g:markdown_fenced_languages=["python"]

augroup my_cm_setup
    autocmd!
    autocmd Filetype markdown,pandoc call ncm2#register_source({
      \ 'name': 'pandoc',
      \ 'priority': 8,
      \ 'scope': ['markdown', 'pandoc'],
      \ 'mark': 'bib',
      \ 'word_pattern': '\w+',
      \ 'complete_pattern': ['@'],
      \ 'on_complete': ['ncm2#on_complete#omni', 'pandoc#completion#Complete'],
      \ })
augroup END

" }}}
" gitgutter {{{

" Cycle changes in all buffers
function! NextHunkAllBuffers()
  let line = line('.')
  GitGutterNextHunk
  if line('.') != line
    return
  endif

  let bufnr = bufnr('')
  while 1
    bnext
    if bufnr('') == bufnr
      return
    endif
    if !empty(GitGutterGetHunks())
      normal! 1G
      GitGutterNextHunk
      return
    endif
  endwhile
endfunction

function! PrevHunkAllBuffers()
  let line = line('.')
  GitGutterPrevHunk
  if line('.') != line
    return
  endif

  let bufnr = bufnr('')
  while 1
    bprevious
    if bufnr('') == bufnr
      return
    endif
    if !empty(GitGutterGetHunks())
      normal! G
      GitGutterPrevHunk
      return
    endif
  endwhile
endfunction

nnoremap <silent> ]c :call NextHunkAllBuffers()<CR>
nnoremap <silent> [c :call PrevHunkAllBuffers()<CR>

" }}}
" neoterm {{{

let g:neoterm_autoinsert = 1
let g:neoterm_default_mod = 'keepalt'
let g:neoterm_autoscroll = 1

" }}}
" Language client neovim {{{

let g:LanguageClient_serverCommands = {
  \ 'cpp': ['clangd'],
  \ 'rust': ['rust-analyzer'],
  \ }

function! SetLSPShortcuts()
  nnoremap <space>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap <space>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <space>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <space>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <space>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <space>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <space>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <space>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <space>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <space>lm :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType cpp,c,rust call SetLSPShortcuts()
augroup END

" }}}
" Vimwiki {{{

nmap <space>wj <Plug>VimwikiDiaryPrevDay
nmap <space>wk <Plug>VimwikiDiaryNextDay

let g:vimwiki_folding = 'syntax'
let g:vimwiki_ext2syntax = {
      \'.md': 'markdown',
      \ '.mkd': 'markdown',
      \ '.wiki': 'media'
      \}
let g:vimwiki_global_ext = 0

" Wiki settings
let s:wiki_default = {}
let s:wiki_default.auto_export = 0
let s:wiki_default.auto_toc = 1
let s:wiki_default.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'sh': 'sh'}
let s:wiki_default.syntax = 'markdown'
let s:wiki_default.ext = '.md'

let s:home_wiki = copy(s:wiki_default)
let s:home_wiki.path = '~/Documents/notes/personal/'
let s:home_wiki.diary_rel_path = 'diary/'
let s:home_wiki.path_html = '~/Documents/notes/html/personal/'

let s:phd_wiki = copy(s:wiki_default)
let s:phd_wiki.path = '~/Documents/notes/PhD/'
let s:phd_wiki.diary_rel_path = 'logbook/'
let s:phd_wiki.diary_index = 'index'
let s:phd_wiki.diary_header = 'PhD Logbook'
let s:phd_wiki.path_html = '~/Documents/notes/html/PhD/'
let s:phd_wiki.auto_export = 0
let s:phd_wiki.html_template = '~/Documents/notes/template.html'
let s:phd_wiki.template_path = '~/Documents/notes/'
let s:phd_wiki.template_default = 'template'
let s:phd_wiki.template_ext = '.html'

let s:inter_wiki = copy(s:wiki_default)
let s:inter_wiki.path = '~/Documents/Work/Intersect/notes/'
let s:inter_wiki.diary_rel_path = 'diary/'
let s:inter_wiki.path_html = '~/Documents/Work/Intersect/html/personal/'
let s:inter_wiki.diary_header = 'Intersect Notes'

let g:vimwiki_list = [s:home_wiki, s:phd_wiki, s:inter_wiki]

" Custom image handler for html
function! VimwikiWikiIncludeHandler(value)
    let l:str = a:value

    " complete URL
    let l:url_0 = matchstr(l:str, vimwiki#vars#get_global('rxWikiInclMatchUrl'))
    " URL parts
    let l:link_infos = vimwiki#base#resolve_link(l:url_0)
    let l:descr = matchstr(l:str, vimwiki#html#incl_match_arg(1))
    let l:verbatim_str = matchstr(l:str, vimwiki#html#incl_match_arg(2))

    let l:link_infos = vimwiki#base#resolve_link(l:url_0)

    let l:url = l:link_infos.filename

    let l:url = escape(l:url, '#')

    if fnamemodify(l:url, ':e') =~? 'pdf'
        let l:line = '<figure>'.
                    \ '<object data='.l:url." type='application/pdf' height=100% width=100%></object>".
                    \'<figcaption>Fig: '.l:descr.'</figcaption>'.
                    \'</figure>'
    else
        let l:line = '<figure>'.
                    \ vimwiki#html#linkify_image(l:url, l:descr, l:verbatim_str).
                    \'<figcaption>Fig: '.l:descr.'</figcaption>'.
                    \'</figure>'
    endif

    " Return the empty string when unable to process link
    return l:line
endfunction


"}}}
" floaterm {{{

let g:floaterm_position = 'center'
let g:floaterm_keymap_toggle = '<space>t'
hi FloatermNF guibg=None
hi FloatermBorderNF guifg=cyan

" }}}
