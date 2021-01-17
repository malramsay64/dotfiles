
set -x EDITOR nvim
set -x VISUAL nvim

set -x NNN_USE_EDITOR 1
set -x NNN_BMS 'd:~/Documents;D:~/Downloads/;p:~/Projects;P:~/Documents/Programming'

set -x  XDG_CONFIG_HOME "$HOME"/.config
set -x  XDG_DATA_HOME "$HOME"/.local/share
set -x  XDG_CACHE_HOME "$HOME"/.cache

set -x LC_TIME "en_GB.UTF-8"

set -Ua fish_user_paths "$HOME/.cargo/bin"
set -Ua fish_user_paths "$HOME/.cargo/bin"
set -Ua fish_user_paths "$HOME/dotfiles/bin"
set -Ua fish_user_paths "$HOME/.local/bin"
set -Ua fish_user_paths "$HOME/dotfiles/bin"

starship init fish | source

direnv hook fish | source

zoxide init fish | source

set -x TASKRC "$XDG_CONFIG_HOME/task/config"

abbr g git
abbr c clear
abbr ravp "rsync -av --progress"

# Commmon misspellings
abbr isntall install
abbr juptyer jupyter
abbr serach search
