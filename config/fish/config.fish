
# No greeting when starting fish
set fish_greeting

set -x DOTFILES "$HOME/dotfiles"

# Enable direnv
eval (direnv hook fish)

# Ensure that GPG Agent is used as the SSH agent
set -e SSH_AUTH_SOCK
set -U -x SSH_AUTH_SOCK ~/.gnupg/S.gpg-agent.ssh

# Setup terminal, and turn on colors
set -x TERM xterm-256color

source "$HOME/.miniconda/etc/fish/conf.d/conda.fish"

set -x GPG_TTY (tty)
