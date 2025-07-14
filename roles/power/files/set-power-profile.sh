#!/bin/bash

set -ex

gpu_level() { echo "$1" | sudo tee /sys/class/drm/card1/device/power_dpm_force_performance_level; }

performance() {
  sudo powerprofilesctl set performance
  sudo cpupower frequency-set -g performance
  sudo cpupower set --turbo-boost 1
  gpu_level "auto"
  adjust-refresh-rate || true
  notify-send 'Performance mode' || true
}

powersaver() {
  sudo powerprofilesctl set power-saver
  sudo cpupower frequency-set -g powersave
  sudo cpupower set --turbo-boost 0
  gpu_level "low"
  adjust-refresh-rate || true
  notify-send 'Powersaver mode' || true
}

case "$1" in
performance) performance ;;
powersaver) powersaver ;;
*) echo "Please enter an action" ;;
esac
