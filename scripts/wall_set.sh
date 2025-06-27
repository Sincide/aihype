#!/usr/bin/env bash
# Simple helper to change wallpaper without re-theming
wall="$1"
if [ -z "$wall" ]; then
  echo "Usage: wall_set.sh /path/to/wallpaper" >&2
  exit 1
fi

if ! pgrep -x swww-daemon >/dev/null; then
  swww-daemon &
  sleep 1
fi
swww img "$wall"
