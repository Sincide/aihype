#!/usr/bin/env bash
# Interactive modprobe loader
set -euo pipefail

module=$(ls /lib/modules/$(uname -r)/kernel | fzf --prompt="Load module > " 2>/dev/null)
if [ -n "$module" ]; then
  sudo modprobe "$module" && notify-send "Module loaded" "$module"
fi
