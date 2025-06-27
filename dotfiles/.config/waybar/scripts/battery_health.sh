#!/usr/bin/env bash
# Battery health and predicted life
set -euo pipefail

if ! command -v upower >/dev/null; then
  echo "no battery" && exit 0
fi

device=$(upower -e | grep BAT | head -n1)
if [ -z "$device" ]; then
  echo "no battery" && exit 0
fi

percent=$(upower -i "$device" | awk '/percentage/ {print $2}')
health=$(upower -i "$device" | awk '/energy-full:/ {full=$2} /energy-full-design/ {design=$2} END { if (design>0) printf "%.0f%%", 100*full/design }')

echo "bat ${percent} health:${health}"
