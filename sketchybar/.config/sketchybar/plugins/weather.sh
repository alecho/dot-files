#!/bin/bash

weather_icon() {
  case "$1" in
    *"Sunny"*|*"Clear"*)            echo "󰖙" ;;
    *"Partly"*|*"partly"*)          echo "󰖕" ;;
    *"Cloudy"*|*"cloudy"*)          echo "" ;;
    *"Overcast"*|*"overcast"*)      echo "" ;;
    *"Mist"*|*"Fog"*|*"Haze"*)     echo "" ;;
    *"Rain"*|*"Drizzle"*|*"rain"*) echo "" ;;
    *"Thunder"*|*"thunder"*)        echo "" ;;
    *"Snow"*|*"Blizzard"*|*"snow"*) echo "" ;;
    *"Sleet"*|*"Ice"*|*"Freezing"*) echo "" ;;
    *)                               echo "" ;;
  esac
}

DATA=$(curl -s "wttr.in/?format=j1&u" 2>/dev/null)

if [ "$DATA" = "" ] || echo "$DATA" | grep -q "Unknown"; then
  sketchybar --set "$NAME" label="--°F" icon=""
  exit 0
fi

# Current conditions
CONDITION=$(echo "$DATA" | jq -r '.current_condition[0].weatherDesc[0].value')
TEMP=$(echo "$DATA" | jq -r '.current_condition[0].temp_F')
FEELS=$(echo "$DATA" | jq -r '.current_condition[0].FeelsLikeF')
HUMIDITY=$(echo "$DATA" | jq -r '.current_condition[0].humidity')
WIND_SPEED=$(echo "$DATA" | jq -r '.current_condition[0].windspeedMiles')
WIND_DIR=$(echo "$DATA" | jq -r '.current_condition[0].winddir16Point')
ICON=$(weather_icon "$CONDITION")

# Set the bar item
sketchybar --set "$NAME" icon="$ICON" label="${TEMP}°F"

# Populate popup items
# Line 1: Current details
LOCATION=$(echo "$DATA" | jq -r '.nearest_area[0] | "\(.areaName[0].value), \(.region[0].value)"')

sketchybar --remove weather.location 2>/dev/null
sketchybar --remove weather.details 2>/dev/null
sketchybar --remove weather.wind 2>/dev/null
sketchybar --remove weather.today 2>/dev/null
sketchybar --remove weather.day1 2>/dev/null
sketchybar --remove weather.day2 2>/dev/null

sketchybar --add item weather.location popup.weather \
           --set weather.location \
                 icon="" \
                 label="$LOCATION" \
                 icon.padding_left=10 \
                 label.padding_right=10

sketchybar --add item weather.details popup.weather \
           --set weather.details \
                 icon="$ICON" \
                 label="${CONDITION}  ${TEMP}°F (feels ${FEELS}°F)" \
                 icon.padding_left=10 \
                 label.padding_right=10

sketchybar --add item weather.wind popup.weather \
           --set weather.wind \
                 icon="" \
                 label="Wind ${WIND_SPEED}mph ${WIND_DIR}   Humidity ${HUMIDITY}%" \
                 icon.padding_left=10 \
                 label.padding_right=10

# 3-day forecast
for i in 0 1 2; do
  DAY_DATE=$(echo "$DATA" | jq -r ".weather[$i].date")
  DAY_HIGH=$(echo "$DATA" | jq -r ".weather[$i].maxtempF")
  DAY_LOW=$(echo "$DATA" | jq -r ".weather[$i].mintempF")
  DAY_DESC=$(echo "$DATA" | jq -r ".weather[$i].hourly[4].weatherDesc[0].value")
  DAY_RAIN=$(echo "$DATA" | jq -r "[.weather[$i].hourly[].chanceofrain | tonumber] | max")
  DAY_ICON=$(weather_icon "$DAY_DESC")

  # Format date
  case $i in
    0) DAY_LABEL="Today" ;;
    1) DAY_LABEL="Tomorrow" ;;
    2) DAY_LABEL=$(date -j -f "%Y-%m-%d" "$DAY_DATE" "+%A" 2>/dev/null || echo "$DAY_DATE") ;;
  esac

  ITEM_NAME="weather.day${i}"
  sketchybar --add item "$ITEM_NAME" popup.weather \
             --set "$ITEM_NAME" \
                   icon="$DAY_ICON" \
                   label="${DAY_LABEL}  ↑${DAY_HIGH}°F ↓${DAY_LOW}°F  ${DAY_RAIN}%" \
                   icon.padding_left=10 \
                   label.padding_right=10
done
