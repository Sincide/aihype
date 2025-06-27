#!/usr/bin/env bash
# Display WM mode: tiling or floating; or editor mode if $EDITOR_MODE set
set -euo pipefail

mode=${EDITOR_MODE:-}
if [ -n "$mode" ]; then
  echo "$mode"
  exit 0
fi

if ! command -v hyprctl >/dev/null; then
  echo "?"
  exit 0
fi
state=$(hyprctl activeworkspace -j 2>/dev/null | jq -r '.floating' 2>/dev/null || echo "")
if [ "$state" = "true" ]; then
  echo "float"
else
  echo "tile"
fi
