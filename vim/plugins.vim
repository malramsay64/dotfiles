" Configuration for Vundle package manager

" Automatic install vim-plug if not already
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup pluginstall
      augroup!
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
Plug 'malramsay64/vim-quantum'

" Examine syntax highlighting rules
Plug 'gerw/vim-HiLinkTrace', { 'on': ['HLT', 'HLT!'] }

" Status bar
Plug 'vim-airline/vim-airline'

" Vim Wiki
"Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
Plug '~/Documents/Programming/vimwiki'

" Syntax checking
Plug 'neomake/neomake'
Plug 'janko-m/vim-test'

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Filetype specific plugins
" Python
Plug 'Vimjas/vim-python-pep8-indent', { 'for': ['python', 'cython'] }
Plug 'davidhalter/jedi-vim', { 'for': ['python', 'cython'] }
Plug 'wmayner/python3-syntax', { 'for': 'python' , 'branch': 'develop' }
Plug 'fs111/pydoc.vim', { 'on': ['Pydoc', 'PydocSearch'] }
Plug 'lambdalisue/vim-cython-syntax'
Plug 'fisadev/vim-isort', Cond(executable('isort'), { 'for': ['python', 'cython'] })

" Other Languages
Plug 'jansenm/vim-cmake', { 'for': 'cmake' }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp', 'c'] }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'dearrrfish/vim-applescript', { 'for': 'applescript' }
Plug 'lumiliet/vim-twig', { 'for': 'twig' }
Plug 'saltstack/salt-vim', { 'for': ['sls', 'saltstack'] }
Plug 'ekalinin/Dockerfile.vim', { 'for': 'Dockerfile' }
Plug 'cespare/vim-toml'
Plug 'robertbasic/vim-hugo-helper', { 'for': 'markdown' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'nelstrom/vim-markdown-folding', { 'for': 'markdown' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" Terminal/REPL
Plug 'hkupty/iron.nvim', Cond(has('nvim'), { 'do': ':UpdateRemotePlugins' })

" Autocomplete
Plug 'Shougo/deoplete.nvim', Cond(has('nvim'), { 'do': ':UpdateRemotePlugins' })
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'zchee/deoplete-jedi', { 'for': ['python', 'cython'] }
Plug 'Rip-Rip/clang_complete', { 'for': ['cpp', 'c'] }
Plug 'Shougo/echodoc.vim'

" Additional text-objects
Plug 'wellle/targets.vim'
Plug 'wvffle/vimterm'

" Writing plugins
Plug 'reedes/vim-pencil', { 'for': ['markdown', 'vimwiki', 'text'] }
Plug 'reedes/vim-litecorrect', { 'for': ['markdown', 'vimwiki', 'text'] }
Plug 'rhysd/vim-grammarous', { 'on': 'GrammarousCheck' }
Plug 'beloglazov/vim-online-thesaurus'
Plug 'junegunn/goyo.vim', { 'on': [ 'Goyo' ] }

" Search and replace
Plug 'haya14busa/incsearch.vim'         " Auto unhighlight search results
Plug 'wincent/loupe'
Plug 'wincent/scalpel'

" General Plugins
Plug 'tpope/vim-fugitive'               " git integration
Plug 'tpope/vim-surround'               " surround text with characters
Plug 'tpope/vim-repeat'                 " repeat with plugins
Plug 'tpope/vim-unimpaired'             " complimentary mappings
Plug 'tpope/vim-speeddating'            " incr/decr dates
Plug 'tpope/vim-vinegar'
Plug 'scrooloose/nerdcommenter'         " commenting code
Plug 'PeterRincker/vim-argumentative'   " manipulating function arguments
Plug 'airblade/vim-gitgutter'           " git diffs
Plug 'szw/vim-tags'                     " ctag support
Plug 'mbbill/undotree'                  " undo
Plug 'nixon/vim-vmath'                  " math on visual selections
Plug 'aperezdc/vim-template'            " Create templates for new files
Plug 'farmergreg/vim-lastplace'         " Remember last location in files
Plug 'godlygeek/tabular'                " Align bits of text
Plug 'majutsushi/tagbar'
Plug 'malramsay64/vim-taskwarrior', Cond(executable('task'))
Plug 'gioele/vim-autoswap'

" all plugins must be added before this line
call plug#end()
