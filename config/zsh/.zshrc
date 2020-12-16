# Profile zsh startup
# Credit: https://kev.inburke.com/kevin/profiling-zsh-startup-time/ 
#
# PROFILE_STARTUP=false
if [[ "$PROFILE_STARTUP" == true ]]; then
    zmodload zsh/zprof # Output load-time statistics
    # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
    PS4=$'%D{%M%S%.} %N:%i> '
    exec 2>"${XDG_CACHE_HOME:-$HOME/tmp}/zsh_statup.$$"
    setopt xtrace prompt_subst
fi

#
# Config
#

unset LS_COLORS

#
# Plugins
#

# Source zsh plugins
# This needs to be a standard source, so can't use source_file function
source "$XDG_CONFIG_HOME/zsh/sourceables.sh"

# Use histdb timer to time each command
autoload -Uz add-zsh-hook

# Use histdb for zsh autosuggestions, with the top result being directory dependent
_zsh_autosuggest_strategy_histdb_top_here() {
    local query="select commands.argv from
history left join commands on history.command_id = commands.rowid
left join places on history.place_id = places.rowid
where places.dir LIKE '$(sql_escape $PWD)%'
and commands.argv LIKE '$(sql_escape $1)%'
group by commands.argv order by count(*) desc limit 1"
    suggestion=$(_histdb_query "$query")
}

ZSH_AUTOSUGGEST_STRATEGY=histdb_top_here

# Use histdb for reverse search
bindkey '^r' _histdb-isearch

# Use neovim-remote when in a neovim buffer
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    if type nvr > /dev/null; then
        alias nvim='nvr'
    fi
fi

# Configure gpg-agent for ssh keys
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

# Have consistent location for forwarded ssh authentication socket
if [[ "$SSH_AUTH_SOCK" == /tmp/* ]]; then
    ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/ssh-agent-sock"
    export SSH_AUTH_SOCK="$HOME/.ssh/ssh-agent-sock"
elif [[ "$SSH_AUTH_SOCK" == /run/* ]]; then
    ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/ssh-agent-sock"
    export SSH_AUTH_SOCK="$HOME/.ssh/ssh-agent-sock"
fi

#
# Initialise Programs
#

# Conda

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/.miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/.miniconda/etc/profile.d/conda.sh" ]; then
        . "$HOME/.miniconda/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/.miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Initialise and configure FZF
source_file "$HOME/.fzf/shell/key-bindings.zsh"
if command -v rg > /dev/null; then
    # Use ripgrep for fzf search
    export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
    # Use ripgrep for ctrl-T search
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Configure rustup
source_file "$HOME"/.cargo/env

# Initialise zoxide command (directory jumper)
if command -v zoxide > /dev/null; then
  eval "$(zoxide init zsh)"
fi

# Initialise direnv (auto activate environment)
if command -v direnv > /dev/null; then
    eval "$(direnv hook zsh)"
fi

# Initialise startship (prompt)
if command -v starship > /dev/null; then
    eval "$(starship init zsh)"
fi

#
# Abbreviations
#

# Aliases
source_file "$XDG_CONFIG_HOME/zsh/aliases.zsh"

#
# Completions
#

# Configure completion options

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' use-cache 1

# 0 -- vanilla completion (abc => abc)
# 1 -- smart case completion (abc => Abc)
# 2 -- word flex completion (abc => A-big-Car)
# 3 -- full flex completion (abc => ABraCadabra)
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
if [[ -f $HOME/.ssh/config ]]; then
  hosts=($(egrep '^Host.*' $HOME/.ssh/config | awk '{print $2}' | grep -v '^*' | sed -e 's/\.*\*$//'))
  zstyle ':completion:*:hosts' hosts $hosts
fi

# Load Completions
autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi
unset updated_at

#
# Profile End
#

if [[ "$PROFILE_STARTUP" == true ]]; then
    zprof
    unsetopt xtrace
    exec 2>&-
fi
