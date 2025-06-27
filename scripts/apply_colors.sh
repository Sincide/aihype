#!/usr/bin/env bash
# Generate color fragments from a theme JSON and reload components
set -euo pipefail

THEME_JSON="${1:-$HOME/.config/themes/colors.json}"
CACHE_DIR="$HOME/.cache/theme"

mkdir -p "$CACHE_DIR"

# Hyprland fragment
jq -r '. as $c | "$background = \($c.background)\n$foreground = \($c.foreground)\n$accent = \($c.accent)" +
  ("\n" + (["color0","color1","color2","color3","color4","color5","color6","color7"] | map("$"+ . + " = " + $c[.]) | join("\n")))' "$THEME_JSON" > "$CACHE_DIR/colors.conf"

# GTK/Waybar colors
jq -r '. as $c | "@define-color background \($c.background);\n@define-color foreground \($c.foreground);\n@define-color accent \($c.accent);" +
  ("\n" + (["color0","color1","color2","color3","color4","color5","color6","color7"] | map("@define-color " + . + " " + $c[.] + ";") | join("\n")))' "$THEME_JSON" > "$CACHE_DIR/colors.css"

# Keep Waybar config in sync
ln -sf "$CACHE_DIR/colors.css" "$HOME/.config/waybar/colors.css"

# Kitty colors
jq -r '. as $c | "foreground \($c.foreground)\nbackground \($c.background)" +
  ("\n" + (["color0","color1","color2","color3","color4","color5","color6","color7"] | map(. + " " + $c[.]) | join("\n")))' "$THEME_JSON" > "$CACHE_DIR/kitty.conf"

# Env file for shells
jq -r 'to_entries|map("export " + (.key | ascii_upcase) + "=" + .value) | .[]' "$THEME_JSON" > "$CACHE_DIR/colors.env"

# Reload components that support live theming
hyprctl reload >/dev/null 2>&1 || true
killall -SIGUSR2 waybar 2>/dev/null || true
