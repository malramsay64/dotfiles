#! /usr/bin/fish
#
# No greeting when starting fish
set fish_greeting

# Unset the shell colours and use fish's colouring
set -gx LS_COLORS
# Setup terminal, and turn on colors
# set -x TERM xterm-256color

set -x DOTFILES "$HOME/dotfiles"

# Update user path
function __check_path_exists
    if test -d $argv
        echo $argv
    end
end

set -x PATH (__check_path_exists /usr/local/bin) $PATH
set -x PATH (__check_path_exists $HOME/go/bin) $PATH
set -x PATH (__check_path_exists $HOME/.fzf/bin) $PATH
set -x PATH (__check_path_exists $HOME/dotfiles/bin) $PATH
set -x PATH (__check_path_exists $HOME/.local/bin) $PATH
set -x PATH (__check_path_exists $HOME/.miniconda/bin) $PATH

if type -q nvim
    set -x EDITOR 'nvim'
else
    set -x EDITOR 'vim'
end
set -x VISUAL $EDITOR
set -x MANPAGER "$EDITOR +'set ft:man' -"

if type -q rg
    set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
    # Use ripgrep for ctrl-T search
    set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
end

direnv hook fish | source

source $HOME/.config/fish/gnupg.fish
source $HOME/.config/fish/alias.fish

# Configure fisher if not installed
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

source (conda info --root)/etc/fish/conf.d/conda.fish
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval (eval $HOME/.miniconda/bin/conda "shell.fish" "hook" $argv)
# <<< conda initialize <<<
