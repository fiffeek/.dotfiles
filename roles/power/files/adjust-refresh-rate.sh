#!/bin/bash

set -x

POWER_STATUS=$(cat /sys/class/power_supply/ACAD/online)

ensure-edp-modes-exist

if [ "$POWER_STATUS" -eq 1 ]; then
  xrandr --verbose --output eDP --mode "2880x1920"
  notify-send "Refresh rate 120" || true
else
  xrandr --verbose --output eDP --mode "2880x1920_60.00"
  notify-send "Refresh rate 60" || true
fi
