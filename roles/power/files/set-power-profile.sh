#!/bin/bash

set -ex

gpu_level() { echo "$1" | sudo tee /sys/class/drm/card1/device/power_dpm_force_performance_level; }

aspm_level() { echo "$1" | sudo tee /sys/module/pcie_aspm/parameters/policy; }

display_backlight_level() { brightnessctl -d amdgpu_bl1 set "$1"; }

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

set_flag() {
  FLAG_LOCATION="$HOME/flags/power"
  FLAG_FILENAME="$1"
  mkdir -p "$FLAG_LOCATION"
  for file in "$FLAG_LOCATION"/*; do echo 0 >"$file"; done
  touch "$FLAG_LOCATION/$FLAG_FILENAME"
  echo 1 >"$FLAG_LOCATION/$FLAG_FILENAME"
}

performance() {
  sudo powerprofilesctl set performance
  sudo cpupower frequency-set -g performance
  sudo cpupower set --turbo-boost 1
  gpu_level "auto"
  adjust-refresh-rate || true
  wifi_level "performance"
  aspm_level "default"
  display_backlight_level "30"
  set_flag "performance" || true
  notify-send 'Performance mode' || true
}

powersaver() {
  sudo powerprofilesctl set power-saver
  sudo cpupower frequency-set -g powersave
  sudo cpupower set --turbo-boost 0
  gpu_level "low"
  adjust-refresh-rate || true
  wifi_level "powersave"
  aspm_level "powersupersave"
  display_backlight_level "6"
  set_flag "powersave" || true
  notify-send 'Powersaver mode' || true
}

(
  flock -w 30 200 || exit 1
  case "$1" in
  performance) performance ;;
  powersaver) powersaver ;;
  *) echo "Please enter an action" ;;
  esac
) 200>/tmp/set-power-profile.lock
