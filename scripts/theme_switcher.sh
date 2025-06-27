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

# create fragments from palette
jq -r '. as $c | "$background = \($c.background)\n$foreground = \($c.foreground)\n$accent = \($c.accent)"' "$HOME/.config/themes/colors.json" > "$HOME/.cache/theme/colors.conf"

jq -r '. as $c | "@define-color background \($c.background);\n@define-color foreground \($c.foreground);\n@define-color accent \($c.accent);"' "$HOME/.config/themes/colors.json" > "$HOME/.cache/theme/colors.css"

jq -r '. as $c | "foreground \($c.foreground)\nbackground \($c.background)\ncolor1 \($c.accent)"' "$HOME/.config/themes/colors.json" > "$HOME/.cache/theme/kitty.conf"

# env file for fish or other shells
jq -r 'to_entries|map("export " + .key | ascii_upcase + "=" + .value) | .[]' "$HOME/.config/themes/colors.json" > "$HOME/.cache/theme/colors.env"

# reload components
hyprctl reload
killall -SIGUSR2 waybar 2>/dev/null
notify-send "Theme updated" "$(basename "$wall")"
