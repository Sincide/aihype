#!/usr/bin/env bash
set -e

# Install packages (Arch Linux only)
PACKAGES=(hyprland waybar kitty fish fuzzel dunst swww jq ollama brightnessctl playerctl grim slurp cliphist pamixer fzf)

if [ "$(uname -s)" != "Linux" ] || [ ! -f /etc/arch-release ]; then
  echo "This install script only supports Arch Linux." >&2
  exit 1
fi

if command -v paru >/dev/null; then
  paru -S --needed --noconfirm "${PACKAGES[@]}"
else
  sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"
fi

# Create config directories
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
mkdir -p "$XDG_CONFIG_HOME"

# Symlink dotfiles (requires GNU stow)
if command -v stow >/dev/null; then
  stow -t "$HOME" dotfiles
else
  echo "stow not found, copying files" >&2
  cp -r dotfiles/.config/* "$XDG_CONFIG_HOME"/
fi

# Copy initial theme
mkdir -p "$XDG_CONFIG_HOME/themes"
cp -n themes/dark/colors.json "$XDG_CONFIG_HOME/themes/colors.json"

# Install helper scripts to ~/.local/bin
mkdir -p "$HOME/.local/bin"
for s in scripts/*.sh; do
  ln -sf "$(pwd)/$s" "$HOME/.local/bin/$(basename "$s")"
done

# Apply default colors
scripts/apply_colors.sh "$XDG_CONFIG_HOME/themes/colors.json"

# Initial theme setup
scripts/theme_switcher.sh "$XDG_CONFIG_HOME/wallpapers/default.jpg" || true
