
# No greeting when starting fish
set fish_greeting

# Unset the shell colours and use fish's colouring
set -gx LS_COLORS
# Setup terminal, and turn on colors
set -x TERM xterm-256color

set -x DOTFILES "$HOME/dotfiles"

if type -q nvim
    set -x EDITOR 'nvim'
else
    set -x EDITOR 'vim'
end
set -x VISUAL $EDITOR
set -x MANPAGER "$EDITOR +'set ft:man' -"

# Ensure that GPG Agent is used as the SSH agent
set -e SSH_AUTH_SOCK
set -U -x SSH_AUTH_SOCK ~/.gnupg/S.gpg-agent.ssh
set -x GPG_TTY (tty)

if type -q rg
    set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
    # Use ripgrep for ctrl-T search
    set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
end

if [ -n "$NVIM_LISTEN_ADDRESS" ]
    alias "nvim" "nvr"
end

# Enable direnv
if type -q direnv
    eval (direnv hook fish)
end

# Enable pipenv completion
# if type -q pipenv
    # eval (pipenv --completion)
# end

if not set -q abbrs_initialized
  set -U abbrs_initialized
  echo -n Setting abbreviations...

  abbr g 'git'
  abbr qsu 'qstat -u $USER'
  abbr qs 'qstat -Jt -u $USER'
  abbr c 'clear'
  abbr isntall 'install'

  echo 'Done'
end
