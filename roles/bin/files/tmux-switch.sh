#!/usr/bin/env bash

set -e

REPOS="$HOME/repos"
export TMUX_FZF_OPTIONS="-p -w 62% -h 38% -m"

# Combined:
# https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer
# https://github.com/sainnhe/tmux-fzf/blob/master/scripts/session.sh

if [[ $# -eq 1 ]]; then
	selected=$1
else
	current_sessions=$(tmux list-sessions -F "#S")
	repos=$(find "$REPOS" -mindepth 1 -maxdepth 1 -printf "%f\n")
	options=($current_sessions "${repos[@]}")
	options=($(printf "%s\n" "${options[@]}" | sort -u))
	# https://github.com/junegunn/fzf/issues/1693
	selected=$(printf "%s\n" "${options[@]}" | fzf-tmux --bind=enter:replace-query+print-query $TMUX_FZF_OPTIONS --preview-window=hidden)
fi

session_name=$(basename ${selected})
dir="$REPOS/$selected"
# some sessions do not have clearly defined cwd
if [ ! -d "${dir}" ]; then
	dir="$HOME"
fi

tmux_running=$(pgrep tmux)
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
	tmux new-session -s $session_name -c $dir
	exit 0
fi

if ! tmux has-session -t=$session_name 2>/dev/null; then
	tmux new-session -ds $session_name -c $dir
fi

tmux switch-client -t $session_name
