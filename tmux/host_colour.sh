# Colour of host in tmux

if-shell '[ -n "$SSH_CLIENT" ] || -n "$SSH_TTY"' 'tm_host_colour=colour9; tm_host_colour=colour9'
