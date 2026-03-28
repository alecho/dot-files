#!/bin/sh

MODE="$(aerospace list-modes --current 2>/dev/null)"

if [ "$MODE" = "" ] || [ "$MODE" = "main" ]; then
  sketchybar --set "$NAME" label="" drawing=off
else
  sketchybar --set "$NAME" label="[$MODE]" drawing=on
fi
