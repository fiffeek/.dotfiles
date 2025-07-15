#!/bin/bash

set -x

for _ in {1..10}; do
  if xrandr >/dev/null 2>&1; then
    break
  fi
  sleep 1
done

OUTPUT="eDP"
MODE_NAME="2880x1920_60.00"
MODELINE="473.25  2880 3112 3424 3968  1920 1923 1933 1989 -hsync +vsync"

if ! xrandr | grep -q "$MODE_NAME"; then
  xrandr --newmode "$MODE_NAME" $MODELINE
  xrandr --addmode $OUTPUT "$MODE_NAME"
else
  echo "Mode $MODE_NAME already exists."
fi
