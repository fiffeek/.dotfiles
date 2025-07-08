#!/bin/sh

VPN_GET_STATUS=$(nmcli -f STATE,TYPE conn show)
VPN_STATUS="$(echo $VPN_GET_STATUS | grep 'wireguard' | cut -f1 -d' ')"

ICON_CONNECTED=""
ICON_DISCONNECTED=""

get_connection_status() {
  # reports connection status and location
  if [ "$VPN_STATUS" = "activated" ]; then
    echo "$ICON_CONNECTED WG"
  else
    echo "$ICON_DISCONNECTED OFF"
  fi
}

case $1 in
"--status") get_connection_status ;;
esac
