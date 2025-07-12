#!/bin/bash

performance() {
  powerprofilesctl set performance
  cpupower frequency-set -g performance
  notify-send 'Performance mode'
}

powersaver() {
  powerprofilesctl set power-saver
  cpupower frequency-set -g powersave
  notify-send 'Powersaver mode'
}

case "$1" in
performance) performance ;;
powersaver) powersaver ;;
*) echo "Please enter an action" ;;
esac
