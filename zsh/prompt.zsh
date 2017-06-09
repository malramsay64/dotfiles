#!/bin/env zsh

autoload -U colors && colors

RPS1='$(git_super_status) $(vi_mode_prompt_info)'
PROMPT='%D{%H:%M} %{$fg[magenta]%}%m %{$fg[green]%}%3~ %{$reset_color%}%(!.#.$) '


