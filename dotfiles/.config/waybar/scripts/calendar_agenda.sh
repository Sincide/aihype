#!/usr/bin/env bash
# Display date and show calendar on click
set -euo pipefail

if [ "${1:-}" = "click" ]; then
  (notify-send "Agenda" "$(cal)" &)
  exit 0
fi

date '+%Y-%m-%d'
