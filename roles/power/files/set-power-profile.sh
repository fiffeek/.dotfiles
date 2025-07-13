#!/bin/bash

set -ex

performance() {
  powerprofilesctl set performance
  cpupower frequency-set -g performance
  cpupower set --turbo-boost 1
  notify-send 'Performance mode' || true
}

powersaver() {
  powerprofilesctl set power-saver
  cpupower frequency-set -g powersave
  cpupower set --turbo-boost 0
  notify-send 'Powersaver mode' || true
}

case "$1" in
performance) performance ;;
powersaver) powersaver ;;
*) echo "Please enter an action" ;;
esac
