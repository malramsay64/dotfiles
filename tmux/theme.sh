# tmux theme configuration file
# heavily based on the configuration of Nick Nisi
# https://github.com/nicknisi/dotfiles/blob/master/tmux/theme.sh


# Colour {{{

tm_colour_active=colour39
tm_colour_inactive=colour241
tm_colour_feature=colour9
tm_colour_music=colour198
tm_active_border_colour=colour39
tm_colour_host=colour5
tm_colour_user=colour3

set -g status-left-length 32
set -g status-right-length 150
set -g status-interval 5

# default status bar colours
set-option -g status-fg $tm_colour_active
set-option -g status-bg default
set-option -g status-attr default

# default window title colours
set-window-option -g window-status-fg $tm_colour_inactive
set-window-option -g window-status-bg default
set -g window-status-format "#I #W"

# active window title colors
set-window-option -g window-status-current-fg $tm_colour_active
set-window-option -g window-status-current-bg default
set-window-option -g  window-status-current-format "#[bold]#I #W"

# pane border
set-option -g pane-border-fg $tm_colour_inactive
set-option -g pane-active-border-fg $tm_active_border_colour

# message text
set-option -g message-bg default
set-option -g message-fg $tm_colour_active

# pane number display
set-option -g display-panes-active-colour $tm_colour_active
set-option -g display-panes-colour $tm_colour_inactive

# clock
set-window-option -g clock-mode-colour $tm_colour_active

tm_tunes="#[fg=$tm_colour_music]#(osascript ~/dotfiles/tmux/spotify.scpt)"
tm_battery="#{battery_status_fg}#{battery_percentage}"

tm_date="#[fg=$tm_colour_inactive] %R %d %b"
tm_host="#[fg=$tm_colour_host,bold]#h"
tm_user="#[fg=$tm_colour_user,bold]#(echo $USER)"
tm_session_name="#[fg=$tm_colour_feature,bold] #S"
tm_nocolour="#[fg=default]"

set -g status-left $tm_session_name' '
set -g status-right $tm_tunes' '$tm_battery' '$tm_date' '$tm_user$tm_nocolour' @ '$tm_host

#}}}

