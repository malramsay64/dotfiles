set -x NNN_USE_EDITOR 1
set -x NNN_BMS 'd:~/Documents;D:~/Downloads/;p:~/Projects;P:~/Documents/Programming'

starship init fish | source

direnv hook fish | source

zoxide init fish | source

alias ls exa

abbr g git
abbr c clear
abbr ravp "rsync -av --progress"

# Commmon misspellings
abbr isntall install
abbr juptyer jupyter
abbr serach search
