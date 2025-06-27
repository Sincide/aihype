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

# Network applet and authentication agent
if command -v nm-applet >/dev/null && ! pgrep -f nm-applet >/dev/null; then
  nm-applet &
fi
if command -v lxpolkit >/dev/null && ! pgrep -f lxpolkit >/dev/null; then
  lxpolkit &
fi

# Clipboard history
if ! pgrep -x wl-paste >/dev/null; then
  wl-paste --type text --watch cliphist store &
fi

# Start waybar
if ! pgrep -x waybar >/dev/null; then
  waybar &
fi

# Apply current theme on login
if [ -f "$HOME/.config/themes/colors.json" ]; then
  apply_colors.sh "$HOME/.config/themes/colors.json" &
fi

