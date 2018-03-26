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
Plug 'tyrannicaltoucan/vim-quantum'

" Examine syntax highlighting rules
Plug 'gerw/vim-HiLinkTrace', { 'on': ['HLT', 'HLT!'] }

" Status bar
Plug 'itchyny/lightline.vim'

" Syntax checking
Plug 'neomake/neomake'
Plug 'janko-m/vim-test'

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all --no-zsh --no-bash' }
Plug 'junegunn/fzf.vim'

" Filetype specific plugins
" Python
Plug 'fs111/pydoc.vim', { 'on': ['Pydoc', 'PydocSearch'] }
Plug 'lambdalisue/vim-cython-syntax'
Plug 'fisadev/vim-isort', Cond(executable('isort'), { 'for': ['python', 'cython'] })

" Other Languages
Plug 'sheerun/vim-polyglot'
"Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'vim-pandoc/vim-pandoc', { 'for': 'markdown' }
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': 'markdown' }


" Autocomplete
Plug 'Shougo/deoplete.nvim', Cond(has('nvim'), { 'do': ':UpdateRemotePlugins' })
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'zchee/deoplete-jedi', { 'for': ['python', 'cython'] }
Plug 'tweekmonster/deoplete-clang2', { 'for': ['cpp', 'c'] }

Plug 'Shougo/echodoc.vim'

" Additional text-objects
Plug 'wellle/targets.vim'
Plug 'wvffle/vimterm'

" Writing plugins
Plug 'reedes/vim-litecorrect', { 'for': ['markdown', 'vimwiki', 'text', 'gitcommit'] }
Plug 'rhysd/vim-grammarous', { 'on': 'GrammarousCheck' }
Plug 'beloglazov/vim-online-thesaurus'
Plug 'ChesleyTan/wordCount.vim', { 'for': ['markdown', 'text', 'gitcommit', 'pandoc'] }

" Search and replace
Plug 'haya14busa/incsearch.vim'         " Auto unhighlight search results
Plug 'wincent/scalpel'

" File Explorer
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }

" General Plugins
Plug 'tpope/vim-fugitive'               " git integration
Plug 'tpope/vim-surround'               " surround text with characters
Plug 'tpope/vim-repeat'                 " repeat with plugins
Plug 'tpope/vim-unimpaired'             " complimentary mappings
Plug 'tpope/vim-speeddating'            " incr/decr dates
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
Plug 'gioele/vim-autoswap'
Plug 'jez/vim-github-hub'

Plug 'malramsay64/nvim-project-log', Cond(has('nvim'), { 'do': ':UpdateRemotePlugins' })

" all plugins must be added before this line
call plug#end()
