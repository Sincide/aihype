#!/usr/bin/env bash
# Autostart services for Hyprland

# Start wallpaper daemon
if ! pgrep -x swww-daemon >/dev/null; then
  swww-daemon &
fi

# Start notification daemon
if ! pgrep -x dunst >/dev/null; then
  dunst &
fi

# Clipboard history
if ! pgrep -x wl-paste >/dev/null; then
  wl-paste --type text --watch cliphist store &
fi

