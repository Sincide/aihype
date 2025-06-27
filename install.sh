#!/usr/bin/env bash
set -e

# Install packages
PACKAGES=(hyprland waybar kitty fish fuzzel dunst swww jq ollama brightnessctl playerctl grim slurp cliphist pamixer fzf)

if command -v paru >/dev/null; then
  paru -S --needed --noconfirm "${PACKAGES[@]}"
else
  sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"
fi

# Create config directories
mkdir -p "$HOME/.config"

# Symlink dotfiles (requires GNU stow)
if command -v stow >/dev/null; then
  stow -t "$HOME" dotfiles
else
  echo "Install 'stow' to manage symlinks" >&2
fi

# Copy initial theme
mkdir -p "$HOME/.config/themes"
cp -n themes/dark/colors.json "$HOME/.config/themes/colors.json"

# Initial theme setup
scripts/theme_switcher.sh "$HOME/.config/wallpapers/default.jpg" || true
