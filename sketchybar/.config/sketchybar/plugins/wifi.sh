#!/bin/sh

SSID="$(ipconfig getsummary en0 2>/dev/null | awk -F' : ' '/SSID : /{print $2}')"

if [ "$SSID" = "" ]; then
  ICON="󰤭"
  LABEL="N/A"
else
  ICON="󰤨"
  LABEL="$SSID"
fi

sketchybar --set "$NAME" icon="$ICON" label="$LABEL"
