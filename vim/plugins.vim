" Configuration for Vundle package manager

call plug#begin()

" Colourschemes
Plug 'chriskempson/base16-vim'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Vim Wiki
Plug 'vimwiki/vimwiki'
"Plug 'tbabej/taskwiki'

" Task warrior
Plug 'blindFS/vim-taskwarrior'

" Syntax checking
"Plug 'scrooloose/syntastic'               " Syntax checking of code
Plug 'neomake/neomake'

Plug 'tpope/vim-fugitive'               " git integration
Plug 'tpope/vim-surround'               " surround text with characters
Plug 'tpope/vim-repeat'                 " repeat with plugins
Plug 'tpope/vim-unimpaired'             " complimentatry mappings
"Plug 'scrooloose/nerdtree'              " file management
Plug 'scrooloose/nerdcommenter'         " commenting code
Plug 'neomake/neomake'                  " Syntax checking of code
Plug 'octol/vim-cpp-enhanced-highlight' " better c++ highlighting
"Plug 'Townk/vim-autoclose'              " autoclose delimeters
Plug 'PeterRincker/vim-argumentative'   " manipulating function arguments
Plug 'airblade/vim-gitgutter'           " git diffs
Plug 'godlygeek/tabular'                " align text


" all plugins must be added before this line
call plug#end()
