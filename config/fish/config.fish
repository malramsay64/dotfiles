set -x NNN_USE_EDITOR 1
set -x NNN_BMS 'd:~/Documents;D:~/Downloads/;p:~/Projects;P:~/Documents/Programming'

starship init fish | source

direnv hook fish | source

zoxide init fish | source


if test -z (pgrep ssh-agent | string collect)
  ssh-agent -c | source > /dev/null
  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
  set -Ux SSH_AGENT_PID $SSH_AGENT_PID
  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
end

alias ls exa

abbr g git
abbr c clear
abbr ravp "rsync -av --progress"

# Commmon misspellings
abbr isntall install
abbr juptyer jupyter
abbr serach search

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval $HOME/.miniconda/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
