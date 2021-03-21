command! -nargs=0 Reload source "$MYVIMRC"

lua << EOF
require('init')
EOF

colorscheme edge
