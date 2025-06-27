#!/usr/bin/env bash
# Apply wallpaper and generate theme

wall="$1"

if [ -z "$wall" ]; then
  echo "Usage: theme_switcher.sh /path/to/wallpaper" >&2
  exit 1
fi

mkdir -p "$HOME/.cache/theme"

# set wallpaper
if ! pgrep -x swww-daemon >/dev/null; then
  swww-daemon &
  sleep 1
fi
swww img "$wall"

THEME="$HOME/.config/themes/colors.json"
PRESET_DIR="$(dirname "$0")/../themes"

if command -v ollama >/dev/null; then
  palette=$(ollama run walpal "$wall" 2>/dev/null) || palette=""
  if [ -n "$palette" ]; then
    echo "$palette" > "$THEME"
  else
    echo "ollama failed, using preset theme" >&2
    cp "$PRESET_DIR/dark/colors.json" "$THEME"
  fi
else
  echo "ollama not found, using preset theme" >&2
  cp "$PRESET_DIR/dark/colors.json" "$THEME"
fi

"$(dirname "$0")/apply_colors.sh" "$THEME"

notify-send "Theme updated" "$(basename "$wall")"
