#!/usr/bin/env bash
# Apply wallpaper and generate theme

wall="$1"

if [ -z "$wall" ]; then
  echo "Usage: theme_switcher.sh /path/to/wallpaper" >&2
  exit 1
fi

# ensure cache directory
mkdir -p "$HOME/.cache/theme"

# set wallpaper
if ! pgrep -x swww-daemon >/dev/null; then
  swww-daemon &
  sleep 1
fi
swww img "$wall"

# generate color palette using local LLM via Ollama
# expected output: JSON with background, foreground and accent keys
palette=$(ollama run walpal "$wall") || {
  echo "ollama failed" >&2
  exit 1
}

echo "$palette" > "$HOME/.config/themes/colors.json"

"$(dirname "$0")/apply_colors.sh" "$HOME/.config/themes/colors.json"

notify-send "Theme updated" "$(basename "$wall")"
