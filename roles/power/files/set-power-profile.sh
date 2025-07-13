#!/bin/bash

set -ex

gpu_level() { echo "$1" | sudo tee /sys/class/drm/card1/device/power_dpm_force_performance_level; }

performance() {
  powerprofilesctl set performance
  cpupower frequency-set -g performance
  cpupower set --turbo-boost 1
  gpu_level "auto"
  notify-send 'Performance mode' || true
}

powersaver() {
  powerprofilesctl set power-saver
  cpupower frequency-set -g powersave
  cpupower set --turbo-boost 0
  gpu_level "low"
  notify-send 'Powersaver mode' || true
}

case "$1" in
performance) performance ;;
powersaver) powersaver ;;
*) echo "Please enter an action" ;;
esac
