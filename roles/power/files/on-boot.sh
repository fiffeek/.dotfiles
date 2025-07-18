#!/bin/bash

set -ex

USERNAME="$1"
POWER_STATUS=$(cat /sys/class/power_supply/ACAD/online)

if [ "$POWER_STATUS" -eq 1 ]; then
  logger "Power connected at boot"
  su - "$USERNAME" -c 'set-power-profile performance'
else
  logger "Running on battery at boot"
  su - "$USERNAME" -c 'set-power-profile powersaver'
fi
