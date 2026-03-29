#!/bin/sh

CONDITION=$(curl -s "wttr.in/?format=%C" 2>/dev/null)
TEMP=$(curl -s "wttr.in/?format=%t&u" 2>/dev/null | sed 's/+//')

if [ "$CONDITION" = "" ] || echo "$CONDITION" | grep -q "Unknown"; then
  sketchybar --set "$NAME" label="--°F" icon=""
  exit 0
fi

case "$CONDITION" in
  *"Sunny"*|*"Clear"*)            ICON="󰖙" ;;
  *"Partly cloudy"*)              ICON="󰖕" ;;
  *"Cloudy"*)                     ICON="" ;;
  *"Overcast"*)                   ICON="" ;;
  *"Mist"*|*"Fog"*|*"Haze"*)      ICON="" ;;
  *"Rain"*|*"Drizzle"*)           ICON="" ;;
  *"Thunderstorm"*|*"Thunder"*)   ICON="" ;;
  *"Snow"*|*"Blizzard"*)          ICON="" ;;
  *"Sleet"*|*"Ice"*|*"Freezing"*) ICON="" ;;
  *)                              ICON="" ;;
esac

sketchybar --set "$NAME" icon="$ICON" label="$TEMP"
