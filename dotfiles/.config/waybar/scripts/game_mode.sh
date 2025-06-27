#!/usr/bin/env bash
# Toggle game mode indicator
set -euo pipefail

state_file="$HOME/.cache/game_mode"

if [ "${1:-}" = "toggle" ]; then
  if [ -f "$state_file" ]; then
    rm -f "$state_file"
    notify-send "Game Mode" "Off"
  else
    touch "$state_file"
    notify-send "Game Mode" "On"
  fi
  exit 0
fi

if [ -f "$state_file" ]; then
  echo "GAME"
fi
