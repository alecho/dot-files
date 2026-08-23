#!/bin/sh

# ponytail: read pmset assertions instead of asking Amphetamine over AppleScript —
# no automation permission for the common case, and it also catches plain `caffeinate`.
active() {
  pmset -g assertions | grep -qE '^ *pid [0-9]+\((Amphetamine|caffeinate)\)'
}

# Toggling does need AppleScript; Amphetamine has no URL scheme (same calls the
# Raycast extension uses: raycast/script-commands commands/apps/amphetamine).
if [ "$1" = "toggle" ]; then
  if active; then
    osascript -e 'tell application "Amphetamine" to end session'
  else
    osascript -e 'tell application "Amphetamine" to start new session'
  fi
  sleep 1
fi

if active; then
  sketchybar --set "$NAME" icon="󰅶" icon.color=0xffbd93f9
else
  sketchybar --set "$NAME" icon="󰾪" icon.color=0x80ffffff
fi
