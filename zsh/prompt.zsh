#!/bin/env zsh

autoload -U colors && colors

function python_version() { 
    echo "version: $(python -V 2>&1 | cut -f 2 -d ' ')" 
}

function _virtualenv_prompt_info {
    if [[ -n "$(whence virtualenv_prompt_info)" ]]; then
        if [ -n "$(whence pyenv_prompt_info)" ]; then
            if [ "$1" = "inline" ]; then
                ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg[blue]%}python::%{$fg[red]%}"
                ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX=""
                virtualenv_prompt_info
            fi
            local _default_version="$(cat $PYENV_ROOT/version 2> /dev/null)"
            [ "$(pyenv_prompt_info)" = "${_default_version}" ] && virtualenv_prompt_info
        else
            virtualenv_prompt_info
        fi
    fi
}


RPS1='$(git_super_status) $(_virtualenv_prompt_info) $(vi_mode_prompt_info)'
PROMPT='%D{%H:%M} %{$fg[magenta]%}%m %{$fg[green]%}%3~ %{$reset_color%}%(!.#.$) '


