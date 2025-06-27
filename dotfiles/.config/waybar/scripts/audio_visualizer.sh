#!/usr/bin/env bash
# Simple audio visualizer using pulseaudio volume level
set -euo pipefail

if ! command -v pamixer >/dev/null; then
  echo "no audio" && exit 0
fi

vol=$(pamixer --get-volume 2>/dev/null || echo 0)
bars=$((vol / 5))
printf 'vol['
for i in $(seq 0 19); do
  if [ $i -lt $bars ]; then printf '#'; else printf '.'; fi
done
printf ']'
