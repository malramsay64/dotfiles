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

" Build markdown composer plugin
function! BuildComposer(info)
  if a:info.status !=# 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction


call plug#begin()

" Colourschemes
Plug 'joshdick/onedark.vim'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'KeitaNakamura/neodark.vim'

Plug 'gerw/vim-HiLinkTrace', { 'on': ['HLT', 'HLT!'] } " Examing syntax highlighting rules

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Vim Wiki
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
"Plug 'tbabej/taskwiki'

" Syntax checking
Plug 'neomake/neomake'
Plug 'janko-m/vim-test'

" Filetype specific plugins
Plug 'fisadev/vim-isort', { 'for': 'python' }
Plug 'bps/vim-textobj-python', { 'for': 'python' }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'wmayner/python3-syntax', { 'for': 'python' , 'branch': 'develop' }
Plug 'fs111/pydoc.vim', { 'on': ['Pydoc', 'PydocSearch'] }

Plug 'jansenm/vim-cmake', { 'for': 'cmake' }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp', 'c'] } " better c++ highlighting

Plug 'lervag/vimtex', { 'for': 'tex' }  " Plugin for latex
Plug 'dearrrfish/vim-applescript', { 'for': 'applescript' }
Plug 'lumiliet/vim-twig', { 'for': 'twig' }
Plug 'saltstack/salt-vim', { 'for': ['sls', 'saltstack'] }
Plug 'ekalinin/Dockerfile.vim', { 'for': 'Dockerfile' }
Plug 'cespare/vim-toml'
Plug 'robertbasic/vim-hugo-helper', { 'for': 'markdown' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" Terminal
Plug 'hkupty/iron.nvim', Cond(has('nvim'), { 'do': ':UpdateRemotePlugins' })
Plug 'mklabs/split-term.vim'

" Denite
Plug 'Shougo/denite.nvim'
Plug 'Shougo/unite.vim'
Plug 'rafaqz/citation.vim'
Plug 'chemzqm/vim-easygit'
Plug 'chemzqm/denite-git'

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
"Plug 'airodactyl/neovim-ranger'
"Plug 'rafaqz/ranger.vim'
"Plug 'tpope/vim-vinegar'


" Writing plugins
Plug 'reedes/vim-pencil', { 'for': ['markdown', 'vimwiki', 'text'] }
Plug 'reedes/vim-litecorrect', { 'for': ['markdown', 'vimwiki', 'text'] }
Plug 'rhysd/vim-grammarous', { 'on': 'GrammarousCheck' }
Plug 'euclio/vim-markdown-composer', Cond(executable('cargo'), { 'for': 'markdown', 'do': function('BuildComposer') })
Plug 'beloglazov/vim-online-thesaurus'
Plug 'junegunn/goyo.vim', { 'on': [ 'Goyo' ] }

Plug 'tpope/vim-fugitive'               " git integration
Plug 'tpope/vim-surround'               " surround text with characters
Plug 'tpope/vim-repeat'                 " repeat with plugins
Plug 'tpope/vim-unimpaired'             " complimentatry mappings
Plug 'tpope/vim-speeddating'            " incr/decr dates
Plug 'scrooloose/nerdcommenter'         " commenting code
Plug 'PeterRincker/vim-argumentative'   " manipulating function arguments
Plug 'airblade/vim-gitgutter'           " git diffs
Plug 'szw/vim-tags'                     " ctag support
Plug 'mbbill/undotree'                  " undo
Plug 'nixon/vim-vmath'                  " math on visual selections
Plug 'haya14busa/incsearch.vim'
Plug 'aperezdc/vim-template'
Plug 'farmergreg/vim-lastplace'


" all plugins must be added before this line
call plug#end()
