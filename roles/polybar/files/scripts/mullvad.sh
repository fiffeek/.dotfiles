#!/bin/sh

VPN_GET_STATUS="mullvad status"
VPN_STATUS="$($VPN_GET_STATUS | grep -Eio 'connected|connecting|disconnected' |
	tr '[:upper:]' '[:lower:]')"
CONNECTED="connected"
CONNECTING="connecting"

ICON_CONNECTED=""
ICON_CONNECTING="ﱱ"
ICON_DISCONNECTED=""

get_connection_status() {
	# reports connection status and location
	if [ "$VPN_STATUS" = "$CONNECTED" ]; then
		report="$($VPN_GET_STATUS | sed -n 's/.*to //p' | sed -n 's/ in.*//p')"
		echo "$ICON_CONNECTED $report"
	elif [ "$VPN_STATUS" = "$CONNECTING" ]; then
		echo "$ICON_CONNECTING Connecting..."

	else
		echo "$ICON_DISCONNECTED OFF"
	fi
}

case $1 in
"--status") get_connection_status ;;
"--connect") mullvad connect ;;
"--reconnect") mullvad reconnect ;;
esac
