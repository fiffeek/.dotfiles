#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done


for m in $(polybar --list-monitors | cut -d":" -f1); do
   MONITOR=$m polybar top 2>&1 | tee -a /tmp/polybar.log & disown
done


echo "Polybar launched..."
