#!/bin/sh
# Instant mode indicator: stream aerospace mode changes and trigger sketchybar.
# Started from aerospace after-startup-command; exits when the aerospace server does.
# ponytail: sed-parse the JSON line instead of pulling in jq.
/opt/homebrew/bin/aerospace subscribe mode-changed | while read -r line; do
  mode=$(printf '%s' "$line" | sed -n 's/.*"mode":"\([^"]*\)".*/\1/p')
  /opt/homebrew/bin/sketchybar --trigger aerospace_mode_change MODE="$mode"
done
