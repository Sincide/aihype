#!/usr/bin/env bash
# Toggle between the light and dark preset themes
set -euo pipefail

THEMES_DIR="$(dirname "$0")/../themes"
CURRENT="$HOME/.config/themes/colors.json"
mkdir -p "$(dirname "$CURRENT")"

if [ ! -f "$CURRENT" ]; then
  cp "$THEMES_DIR/dark/colors.json" "$CURRENT"
  next="dark"
else
  bg=$(jq -r '.background' "$CURRENT" 2>/dev/null || echo "")
  if [ "$bg" = "#fdf6e3" ]; then
    cp "$THEMES_DIR/dark/colors.json" "$CURRENT"
    next="dark"
  else
    cp "$THEMES_DIR/light/colors.json" "$CURRENT"
    next="light"
  fi
fi

"$(dirname "$0")/apply_colors.sh" "$CURRENT"
notify-send "Theme switched" "$next"
