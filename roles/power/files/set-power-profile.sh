#!/bin/bash

set -ex

gpu_level() { echo "$1" | sudo tee /sys/class/drm/card1/device/power_dpm_force_performance_level; }

wifi_level() {
  NM_CONFIG="/etc/NetworkManager/conf.d/default-wifi-powersave-on.conf"
  if [ "$1" = "powersave" ]; then
    sudo sed -i 's/2/3/' "$NM_CONFIG"
  fi
  if [ "$1" = "performance" ]; then
    sudo sed -i 's/3/2/' "$NM_CONFIG"
  fi
  sudo systemctl restart NetworkManager
}

performance() {
  sudo powerprofilesctl set performance
  sudo cpupower frequency-set -g performance
  sudo cpupower set --turbo-boost 1
  gpu_level "auto"
  adjust-refresh-rate || true
  wifi_level "performance"
  notify-send 'Performance mode' || true
}

powersaver() {
  sudo powerprofilesctl set power-saver
  sudo cpupower frequency-set -g powersave
  sudo cpupower set --turbo-boost 0
  gpu_level "low"
  adjust-refresh-rate || true
  wifi_level "powersave"
  notify-send 'Powersaver mode' || true
}

case "$1" in
performance) performance ;;
powersaver) powersaver ;;
*) echo "Please enter an action" ;;
esac
