" Configuration for Vundle package manager

" Automatic install vim-plug if not already
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Helper function for neovim only plugins
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Function to update remote plugins
function! DoRemote()
    UpdateRemotePlugins
endfunction

" Build markdown composer plugin
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction


call plug#begin()

" Colourschemes
Plug 'rakr/vim-one'
Plug 'gerw/vim-HiLinkTrace', { 'on': ['HLT', 'HLT!'] } " Examing syntax highlighting rules
Plug 'joshdick/onedark.vim'
Plug 'monkoose/boa.vim'
Plug 'dikiaap/minimalist'
Plug 'chriskempson/base16-vim'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Vim Wiki
Plug 'malramsay64/vimwiki', { 'branch': 'dev' }

" Task warrior
Plug 'malramsay64/vim-taskwarrior', Cond(system('hash task && echo 1'))

" Syntax checking
Plug 'neomake/neomake'

" Filetype specific plugins
Plug 'fisadev/vim-isort', { 'for': 'python' }
Plug 'bps/vim-textobj-python', { 'for': 'python' }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
Plug 'wilywampa/vim-ipython', Cond(has('nvim'), { 'for': 'python' })
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'cjrh/vim-conda'


Plug 'jansenm/vim-cmake', { 'for': 'cmake' }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp', 'c'] } " better c++ highlighting

Plug 'lervag/vimtex', { 'for': 'tex' }  " Plugin for latex
Plug 'dearrrfish/vim-applescript', { 'for': 'applescript' }
Plug 'lumiliet/vim-twig', { 'for': 'twig' }
Plug 'saltstack/salt-vim', { 'for': ['sls', 'saltstack'] }
Plug 'ekalinin/Dockerfile.vim', { 'for': 'Dockerfile' }

" Denite
Plug 'Shougo/denite.nvim'
Plug 'rafaqz/citation.vim'

" Autocomplete
Plug 'Shougo/deoplete.nvim', Cond(has('nvim'), { 'do': ':UpdateRemotePlugins' })
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'Rip-Rip/clang_complete', { 'for': ['cpp', 'c'] }
Plug 'Shougo/echodoc.vim'

" Additional text-objects
Plug 'kana/vim-textobj-user'

" File management
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeFind', 'NERDTreeToggle'] }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': ['NERDTreeFind', 'NERDTreeToggle'] }
Plug 'vim-ctrlspace/vim-ctrlspace'

" Writing plugins
Plug 'reedes/vim-pencil', { 'for': ['markdown', 'vimwiki', 'text'] }
Plug 'reedes/vim-litecorrect', { 'for': ['markdown', 'vimwiki', 'text'] }
Plug 'rhysd/vim-grammarous'
Plug 'euclio/vim-markdown-composer', { 'for': 'markdown', 'do': function('BuildComposer') }

Plug 'tpope/vim-fugitive'               " git integration
Plug 'tpope/vim-surround'               " surround text with characters
Plug 'tpope/vim-repeat'                 " repeat with plugins
Plug 'tpope/vim-unimpaired'             " complimentatry mappings
Plug 'scrooloose/nerdcommenter'         " commenting code
Plug 'PeterRincker/vim-argumentative'   " manipulating function arguments
Plug 'airblade/vim-gitgutter'            " git diffs
Plug 'szw/vim-tags'                      " ctag support
Plug 'mbbill/undotree'                  " undo
Plug 'nixon/vim-vmath'                  " math on visual selections
Plug 'haya14busa/incsearch.vim'
Plug 'aperezdc/vim-template'
Plug 'mklabs/split-term.vim'


" all plugins must be added before this line
call plug#end()
