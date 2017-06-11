#!/bin/env zsh

autoload -U colors && colors

RPS1='$(git_super_status)'
PROMPT='%D{%H:%M} %{$fg[magenta]%}%m %{$fg[green]%}%3~ %{$reset_color%}%(!.#.$) '


