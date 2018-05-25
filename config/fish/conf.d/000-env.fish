function __check_path_exists
    if test -d $argv
        echo $argv
    end
end

set -x fish_user_paths $fish_user_paths (__check_path_exists $HOME/.pyenv/bin)
set -x fish_user_paths $fish_user_paths (__check_path_exists $HOME/.local/bin)
set -x fish_user_paths $fish_user_paths (__check_path_exists $HOME/.fzf/bin)
set -x fish_user_paths $fish_user_paths (__check_path_exists $HOME/dotfiles/bin)
set -x fish_user_paths $fish_user_paths (__check_path_exists $HOME/go/bin)
set -x fish_user_paths $fish_user_paths (__check_path_exists /usr/local/bin)
