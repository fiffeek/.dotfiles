#!/usr/bin/env bash

# TokyoNight colors for Tmux

set -g mode-style "fg=#778196,bg=#373c4f"

set -g message-style "fg=#778196,bg=#373c4f"
set -g message-command-style "fg=#778196,bg=#373c4f"

set -g pane-border-style "fg=#373c4f"
set -g pane-active-border-style "fg=#778196"

set -g status "on"
set -g status-justify "left"

set -g status-style "fg=#778196,bg=#16161e"

set -g status-left-length "100"
set -g status-right-length "100"

set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=#15161e,bg=#778196,bold] #S #[fg=#778196,bg=#16161e,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#778196,bg=#16161e] #{prefix_highlight} #[fg=#373c4f,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#778196,bg=#373c4f] %Y-%m-%d  %I:%M %p #[fg=#778196,bg=#373c4f,nobold,nounderscore,noitalics]#[fg=#15161e,bg=#778196,bold] #h "

setw -g window-status-activity-style "underscore,fg=#a9b1d6,bg=#16161e"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#a9b1d6,bg=#16161e"
setw -g window-status-format "#[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#16161e,bg=#373c4f,nobold,nounderscore,noitalics]#[fg=#778196,bg=#373c4f,bold] #I  #W #F #[fg=#373c4f,bg=#16161e,nobold,nounderscore,noitalics]"

# tmux-plugins/tmux-prefix-highlight support
set -g @prefix_highlight_output_prefix "#[fg=#e0af68]#[bg=#16161e]#[fg=#16161e]#[bg=#e0af68]"
set -g @prefix_highlight_output_suffix ""

set -g status-bg default
