#!/bin/bash

sex -e

POWER_STATUS=$(cat /sys/class/power_supply/ACAD/online)

if [ "$POWER_STATUS" -eq 1 ]; then
  logger "Power connected at boot"
  set-power-profile performance
else
  logger "Running on battery at boot"
  set-power-profile powersaver
fi
