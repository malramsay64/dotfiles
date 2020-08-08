" Malcolm Ramsay  .vimrc
"
"General {{{

set encoding=utf-8
scriptencoding utf-8

" leader is <space>
let g:mapleader="\<space>"

let g:vim_home = expand('~/.config/nvim')
let config_list = [
  \ 'plugins.vim',
  \ 'plugin_config.vim'
  \]

for s:config_file in config_list
  let file = glob(g:vim_home . '/' . s:config_file)
  exec 'source' file
endfor

set autoread                            " Vim automatically reads changes to a file

augroup vimrc
    autocmd!
    autocmd BufEnter * :checktime       " Reload changes on FocusGained
augroup END

filetype plugin indent on               " load filetype specific indent and plugin files

""" Python configuration
let g:loaded_python_provider = 1

if isdirectory($HOME.'/.miniconda/envs/neovim')
    let g:python3_host_prog = $HOME.'/.miniconda/envs/neovim/bin/python'
endif

let g:email = 'malramsay64@gmail.com'
let g:username = 'Malcolm Ramsay'

" Use existing neovim session if opening from terminal
if has('nvim') && executable('nvr')
  let $VISUAL = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif

if exists('&belloff')
    set belloff=all                     " Turn off all bells
endif

"}}}
"Colours {{{

syntax enable                           " enable syntax processing

" Enable truecolour support in neovim >= 0.1.5 || vim >= 7.4.1799
if has('termguicolors')
    set termguicolors
endif

" Load colourscheme in vim with tmux
if !has('nvim')
    set t_8b=[48;2;%lu;%lu;%lum
    set t_8f=[38;2;%lu;%lu;%lum
endif

""" Configure Colourscheme
let g:quantum_italics=1

" Colourscheme override
augroup colourOverride
   autocmd!
   autocmd ColorScheme * highlight Conceal guibg=NONE
   autocmd Colorscheme * highlight SpellBad guibg=NONE
   autocmd Colorscheme * highlight SpellCap guibg=NONE
   autocmd Colorscheme * highlight SpellLocal guibg=NONE
   autocmd Colorscheme * highlight SpellRare guibg=NONE
   autocmd Colorscheme * highlight CursorLineNr guibg=NONE
augroup END

set background=dark " for the dark version
colorscheme quantum

" }}}
"Spaces and Tabs {{{

set tabstop=4           " number of visual spaces per TAB
set softtabstop=4       " number of spaces inserted upon TAB
set shiftwidth=4        " autoindent amount when using cindent
set expandtab           " TAB inserts softtabstop spaces

set autoindent          " copy indentation from previous line
set nosmartindent       " inserts extra indentation in some cases

" Remove trailing whitespace from file and return cursor to current position
function! StripTrailingWhitespaces()
    let l:pos = winsaveview()
    execute('%s/\s\+$//e')
    call winrestview(l:pos)
endfun

nnoremap <Space>zz :call StripTrailingWhitespaces()<CR>

"}}}
"UI Config {{{


" The combination of relative number and number gives the absolute line
" number for the current line and relative numbers for all others
set relativenumber                      " show relative line numbers
set number                              " show line numbers
set scrolloff=5                         " 5 lines above and below cursor when scrolling
set wildmenu                            " visual autocomplete for command
set wildmode=longest:full,full          " Complete to longest matching text then first match. Like shell completion
set lazyredraw                          " redraw only when need to
set hidden                              " allows you to hide buffers with unsaved changes without being prompted
set noshowmatch                         " highlight matching parenthesis/bracket/brace
set laststatus=2                        " Display statusline
set splitright                          " open splits by default to the right
set nosplitbelow                        " open splits above current
set formatoptions+=n                    " smart auto-indenting inside numbered lists
set formatoptions+=j                    " smart comment joining
set nojoinspaces                        " don't autoinsert two spaces after '.', '?', '!' for join command
set textwidth=88                        " Textwidth is 88 columns

" common mistypings of exit and save
cabbrev W w
cabbrev Q q
cabbrev Wq wq
cabbrev WQ wq

" Unicode UI elements
if has('linebreak')
  let &showbreak='⤷ '          " ARROW POINTING DOWNWARDS THEN CURVING RIGHTWARDS (U+2937, UTF-8: E2 A4 B7)
endif
set fillchars=vert:│           " BOX DRAWINGS LIGHT VERTICAL (U+2502, UTF-8: E2 94 82)

set list                       " we want to show whitespace elements
set listchars=tab:▶‒
set listchars+=nbsp:␣
set listchars+=extends:»       " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=precedes:«      " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:•         " BULLET (U+2022, UTF-8: E2 80 A2)

"" Movement
set backspace=eol,start,indent  " backspace deletes newlines
set whichwrap+=<,>,h,l,[,]      " left right wraps to next/previous lines

" Movement between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
if has('nvim')
  tnoremap <C-h> <C-\><C-N><C-w>h
  tnoremap <C-j> <C-\><C-N><C-w>j
  tnoremap <C-k> <C-\><C-N><C-w>k
  tnoremap <C-l> <C-\><C-N><C-w>l
endif

" Consistency with yank
nnoremap Y y$

augroup gopass_security
    " Don't backup gopass files.
    autocmd BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile
augroup end

"}}}
" Custom Shortcuts {{{

" jk is escape
inoremap jk <esc>
inoremap jK <esc>
inoremap JK <esc>
inoremap Jk <esc>


" go to next split
nnoremap <space>w <c-w>w
" Turn off search highlighting
nnoremap <space>h :nohlsearch<CR>
" Reload vimrc
nnoremap <space>r :source $MYVIMRC<CR>
" Edit vimrc
nnoremap <space>er :edit $MYVIMRC<CR>
" Edit plugins
nnoremap <space>ep :edit ~/.config/nvim/plugins.vim<CR>
" Edit UnltiSnips
nnoremap <space>es :UltiSnipsEdit<CR>
" Edit in ftplugin directory
" nnoremap <space>ef :edit ~/.vim/ftplugin<CR>
" Edit in tmux config
nnoremap <space>et :edit ~/.tmux.conf<CR>
" Edit bashrc
nnoremap <space>eb :edit ~/.bashrc<CR>
" Edit zshrc
nnoremap <space>ez :edit ~/.zshrc<CR>
" Edit vim direcotry
"nnoremap <space>ed :edit $DOTFILES/vim/<CR>
" Edit denite config
nnoremap <space>ed :edit $DOTFILES/vim/denite.vim<CR>
" <C-s> will correct previous spelling mistake and set undo point
nnoremap <silent> <C-s> :call spelling#fix_previous()<CR>
inoremap <silent> <C-s> <C-g>u<C-o>:call spelling#fix_previous()<CR>
" navigate between tabs
nnoremap ]w :tabnext<CR>
nnoremap [w :tabprev<CR>
" Remap for digraphs
inoremap <C-y> <C-k>

" Open last buffer
nnoremap <space><space> <C-^>

" Shortcut for saving file as root
" cmap w!! w !sudo tee > /dev/null %
cmap w!! w suda://%

" Faster window resizing
nnoremap <C-w>- :5wincmd -<CR>
nnoremap <C-w>= :5wincmd +<CR>
nnoremap <C-w>+ :wincmd =<CR>
nnoremap <space>vj :5wincmd +<CR>
nnoremap <space>vk :5wincmd -<CR>
nnoremap <space>w= :wincmd =<CR>

"}}}
"Searching {{{

set incsearch " search as characters entered
set hlsearch  " highlight matches
set ignorecase " ignore case when searching
set smartcase " overrides ignorecase if uppercase characters in search query

set magic     " regular expressions

" Use ripgrep for search if available
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

"}}}
"Folding {{{

set foldenable         " enable folding
set foldlevelstart=5   " have all levels open by default
set foldnestmax=2      " Maximum number of nested folds
set foldmethod=syntax  " fold based on indent

set modelines=1        " last line of file is checked to run as a command

"}}}
"Backups {{{

if exists('$SUDO_USER')
    set nobackup        " Don't write backups for root files
    set nowritebackup   " No backups when root user
    set noswapfile      " no swap files for root user

    if has('persistent_undo')
        set noundofile  " no undo for root user
    endif
else
    set backup          " Performs backups
    set writebackup     " perform backup
    set backupdir=~/.vim-tmp,~/.tmp,. " Backup directories

    set directory=~/.vim-tmp/swap//,~/.tmp/swap//,. " Directories for swap files

    if has('persistent_undo')
        set undofile
        set undodir=~/.vim-tmp/undo     "undo directory
        set undodir+=~/.tmp/undo
        set undodir+=.
    endif
endif

"}}}
"Spelling and Files{{{

set spelllang=en_au             " spelling language is English Australian
set fileformats=unix,mac,dos    " default line ending is unix
set nospell                     " Spelling is off by default, but is turned on for many filetypes

" set filetype defaults
augroup filetypes
    autocmd!
    if has('nvim')
        autocmd TermOpen * setlocal nonumber norelativenumber
    endif
augroup END

"}}}
" vim: foldmethod=marker foldlevel=0 filetype=vim tabstop=2 softtabstop=2 shiftwidth=2
