#!/bin/bash

performance() {
  powerprofilesctl set performance
  cpupower frequency-set -g performance
  notify-send 'Performance mode' || true
}

powersaver() {
  powerprofilesctl set power-saver
  cpupower frequency-set -g powersave
  notify-send 'Powersaver mode' || true
}

case "$1" in
performance) performance ;;
powersaver) powersaver ;;
*) echo "Please enter an action" ;;
esac
