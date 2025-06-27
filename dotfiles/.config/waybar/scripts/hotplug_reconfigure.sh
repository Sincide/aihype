#!/usr/bin/env bash
# Rebuild waybar on monitor hotplug
set -euo pipefail

swaymsg -t subscribe '["output"]' | while read -r _; do
  pkill -SIGUSR2 waybar
done
