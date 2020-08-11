" Configuration for vim-plug package manager

" Automatic install vim-plug if not already
let s:vim_plug_file = glob(g:vim_home . '/autoload/plug.vim')
if empty(s:vim_plug_file)
  silent !curl -fLo s:vim_plug_file --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup pluginstall
      autocmd!
      autocmd VimEnter * PlugInstall | source $MYVIMRC
  augroup END
endif

" Helper function for neovim only plugins
function! Cond(cond, ...)
  let l:opts = get(a:000, 0, {})
  return a:cond ? l:opts : extend(l:opts, { 'on': [], 'for': [] })
endfunction

" Function to update remote plugins
function! DoRemote()
    UpdateRemotePlugins
endfunction

call plug#begin()

" Colourschemes
Plug 'tyrannicaltoucan/vim-quantum'

" Examine syntax highlighting rules
Plug 'gerw/vim-HiLinkTrace', { 'on': ['HLT', 'HLT!'] }

" Status bar
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'

" Syntax checking
Plug 'w0rp/ale'

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Additional text-objects
Plug 'wellle/targets.vim'
Plug 'kana/vim-textobj-user'            " Custom text objects

" Filetype specific plugins
" Python
Plug 'lambdalisue/vim-cython-syntax'
Plug 'bps/vim-textobj-python', { 'for': ['python', 'cython'] }

" Other Languages
Plug 'sheerun/vim-polyglot'
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'malramsay64/vim-pandoc-syntax', { 'for': ['pandoc', 'markdown'] }
Plug 'gu-fan/riv.vim'

" vim -> nvim compatability
if !has("nvim")
    Plug 'roxma/vim-hug-neovim-rpc'
endif

" Language Clients
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Autocomplete
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

Plug 'ncm2/ncm2-bufword'           " Completions from words in current buffer
Plug 'ncm2/ncm2-path'              " Complete file paths
Plug 'ncm2/ncm2-github'            " Complete GitHub repository, user, link, and issues
Plug 'ncm2/ncm2-jedi'              " Python completion with Jedi
Plug 'ncm2/ncm2-ultisnips'         " Ultisnips snippet completion
Plug 'ncm2/ncm2-tmux'              " Completion from other tmux panes
Plug 'ncm2/ncm2-pyclang'

" Sub-scopes
" These plugins detect other programming languages within a document and activate the relevant
" completion for them.
Plug 'malramsay64/ncm2-pandoc-subscope' " Detect in Markdown and pandoc documents
Plug 'ncm2/ncm2-rst-subscope'      " Detect in reStructured Text documents

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Writing plugins
let g:text_files = ['markdown', 'vimwiki', 'text', 'gitcommit', 'pandoc', 'rst']
Plug 'reedes/vim-litecorrect', { 'for': text_files }
Plug 'ChesleyTan/wordCount.vim', { 'for': text_files }
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'ron89/thesaurus_query.vim',  { 'on': ['ThesaurusQueryReplaceCurrentWord', 'Thesaurus'] }

" Search and replace
Plug 'haya14busa/incsearch.vim'         " Auto unhighlight search results
Plug 'wincent/scalpel'

" Git Plugins
Plug 'tpope/vim-fugitive'               " git integration
Plug 'tpope/vim-rhubarb'                " hub integration
Plug 'jez/vim-github-hub'               " Formatting of hub commit, issues, pull-requests
Plug 'junegunn/gv.vim'                  " Browse git history
Plug 'whiteinge/diffconflicts'
Plug 'airblade/vim-gitgutter'           " git diffs

" General Plugins
Plug 'tpope/vim-surround'               " surround text with characters
Plug 'tpope/vim-repeat'                 " repeat with plugins
Plug 'tpope/vim-unimpaired'             " complimentary mappings
Plug 'tpope/vim-speeddating'            " incr/decr dates
Plug 'justinmk/vim-dirvish'             " Directory manipulation
Plug 'tpope/vim-abolish'                " Coercion and useful tools
Plug 'scrooloose/nerdcommenter'         " commenting code
Plug 'PeterRincker/vim-argumentative'   " manipulating function arguments
Plug 'mbbill/undotree'                  " undo
Plug 'aperezdc/vim-template'            " Create templates for new files
Plug 'farmergreg/vim-lastplace'         " Remember last location in files
Plug 'gioele/vim-autoswap'              " Automatically deal with swap files
Plug 'tommcdo/vim-lion'                 " Align based on characters
Plug 'lambdalisue/suda.vim'             " Allow write with sudo
Plug 'kassio/neoterm'
Plug 'direnv/direnv.vim'
Plug 'vimlab/split-term.vim'
Plug 'vimwiki/vimwiki'

if has("nvim-0.4.0")                " Floating window support arrived in 0.4.0
    Plug 'ncm2/float-preview.nvim'
    Plug 'voldikss/vim-floaterm'
endif

" Tool to provide better methods of moving within vim
" Plug 'AlphaMycelium/pathfinder.vim'

" Plug '~/Projects/markdown-syntax-rs'

" all plugins must be added before this line
call plug#end()