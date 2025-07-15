#!/bin/bash

ICON_POWERSAVE=""
ICON_PERFORMANCE="󰨢"
FLAGS_DIR="$HOME/flags/power"

print_icon() {
  if [ -f "$FLAGS_DIR/$1" ] && [ "$(cat "$FLAGS_DIR/$1")" = "1" ]; then
    echo "$2"
  fi
}

get_power_status() {
  print_icon "performance" "$ICON_PERFORMANCE PF"
  print_icon "powersave" "$ICON_POWERSAVE PS"
}

case "$1" in
"--status") get_power_status ;;
esac
