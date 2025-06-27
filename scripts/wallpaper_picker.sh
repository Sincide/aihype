#!/usr/bin/env bash
# Select a wallpaper with preview using fzf and kitty icat
set -euo pipefail

DIR="${1:-$HOME/Pictures/wallpapers}"

if [ ! -d "$DIR" ]; then
  echo "Wallpaper directory '$DIR' not found" >&2
  exit 1
fi

cd "$DIR"

preview='kitty +kitten icat --clear --transfer-mode=file --stdin=no {}'

choice=$(find . -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.webp" \) \
  | sort | fzf --prompt="Select wallpaper > " \
        --preview="$preview" --preview-window=right:60%)

if [ -n "$choice" ]; then
  "$(dirname "$0")/theme_switcher.sh" "$DIR/${choice#./}"
fi
