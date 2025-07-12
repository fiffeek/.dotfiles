#!/bin/bash

performance() {
  powerprofilesctl set performance
  notify-send 'Performance mode'
}

powersaver() {
  powerprofilesctl set power-saver
  notify-send 'Powersaver mode'
}

case "$1" in
performance) performance ;;
powersaver) powersaver ;;
*) echo "Please enter an action" ;;
esac
