#!/bin/sh

bluetooth_print() {
    if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
    then
        echo "󰂲 OFF"
    else
        echo "󰂯 ON"
    fi
}

bluetooth_toggle() {
    if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
    then
        bluetoothctl power on
    else
        bluetoothctl power off
    fi
}

case "$1" in
    --toggle)
        bluetooth_toggle
        ;;
    *)
        bluetooth_print
        ;;
esac
