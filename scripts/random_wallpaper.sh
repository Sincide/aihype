#!/usr/bin/env bash
# Set a random wallpaper from a directory and generate a matching theme
set -euo pipefail

DIR="${1:-$HOME/Pictures/wallpapers}"

if [ ! -d "$DIR" ]; then
  echo "Wallpaper directory '$DIR' not found" >&2
  exit 1
fi

wall=$(find "$DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.webp" \) | shuf -n 1)

if [ -n "$wall" ]; then
  "$(dirname "$0")/theme_switcher.sh" "$wall"
fi
