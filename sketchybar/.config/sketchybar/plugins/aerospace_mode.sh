#!/bin/sh

# Prefer MODE passed by aerospace's on-mode-changed trigger (avoids a race with
# `aerospace list-modes --current`); fall back to querying for manual triggers.
MODE="${MODE:-$(aerospace list-modes --current 2>/dev/null)}"

if [ "$MODE" = "" ] || [ "$MODE" = "main" ]; then
  sketchybar --set "$NAME" label="" drawing=off
else
  sketchybar --set "$NAME" label="[$MODE]" drawing=on
fi
