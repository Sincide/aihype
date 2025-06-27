#!/usr/bin/env bash
# Show active window class and title
set -euo pipefail

if ! command -v hyprctl >/dev/null; then
  echo "hyprctl missing" && exit 1
fi

info=$(hyprctl activewindow -j 2>/dev/null || true)
if [ -z "$info" ]; then
  echo "No window"
  exit 0
fi
class=$(echo "$info" | jq -r '.class' 2>/dev/null || echo "?")
title=$(echo "$info" | jq -r '.title' 2>/dev/null || echo "?")

printf '%s: %s' "$class" "$title"
