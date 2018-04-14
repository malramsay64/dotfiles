
# No greeting when starting fish
set fish_greeting

set -x DOTFILES "$HOME/dotfiles"

set -x fish_user_paths $HOME/.local/bin $HOME/.fzf/bin $HOME/dotfiles/bin $HOME/go/bin /usr/local/bin

# Enable direnv
eval (direnv hook fish)

if type -q nvim
    set -x EDITOR 'nvim'
else
    set -x EDITOR 'vim'
end
set -x VISUAL $EDITOR
set -x MANPAGER "$EDITOR +'set ft:man' -"

set -gx LSCOLORS
# Ensure that GPG Agent is used as the SSH agent
set -e SSH_AUTH_SOCK
set -U -x SSH_AUTH_SOCK ~/.gnupg/S.gpg-agent.ssh

# Setup terminal, and turn on colors
set -x TERM xterm-256color

if type -q rg
    set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
    # Use ripgrep for ctrl-T search
    set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
end

. $HOME/.config/fish/gnupg.fish

if [ -n "$NVIM_LISTEN_ADDRESS" ]
    alias "nvim" "nvr"
end

source "$HOME/.miniconda/etc/fish/conf.d/conda.fish"

set -x GPG_TTY (tty)

if not set -q abbrs_initialized
  set -U abbrs_initialized
  echo -n Setting abbreviations...

  abbr g 'git'
  abbr qsu 'qstat -u $USER'
  abbr qs 'qstat -Jt -u $USER'
  abbr c 'clear'

  echo 'Done'
end

if type -q thefuck
    thefuck --alias | source
end
