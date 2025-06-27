# Arch Linux Modular Wayland Setup

This repository contains a modular configuration for a minimal Wayland desktop on Arch Linux.

## Overview

The setup uses **Hyprland** as the compositor with supporting applications:

- **Waybar**: Status bar
- **Kitty**: Terminal emulator
- **Fish**: Shell
- **Fuzzel**: Application launcher
- **Dunst**: Notification daemon

Dynamic theming is powered by a local LLM via **Ollama**. Colors are extracted from the selected wallpaper and written to `themes/colors.json`. Generated fragments are placed in `~/.cache/theme/` and imported by the individual configs.

Configuration files are stored in `dotfiles/.config` so they can be managed with `stow` or any dotfile manager. Scripts live under `scripts/` and themes under `themes/`.
Additional utilities handle wallpaper management and theming.

## Theme Generation Workflow

1. Run `scripts/theme_switcher.sh /path/to/wallpaper.jpg`.
2. The script sets the wallpaper using `swww` and calls `ollama` to generate a color palette.
3. Color fragments for Hyprland, Waybar, Kitty, Dunst and Fuzzel are written to `~/.cache/theme/`.
4. The components are reloaded so the new palette takes effect.

## Wallpaper Selection

Use `scripts/wallpaper_picker.sh` to browse wallpapers with previews and apply
them together with a freshly generated theme. Wallpapers are looked up in
`~/Pictures/wallpapers` by default but a directory can be provided as an
argument. A helper `scripts/random_wallpaper.sh` picks a random image from the
same location and re-generates the theme automatically.


## Keybindings

Key | Action
----|-------
Super + Enter | Launch Kitty
Super + D | Launch Fuzzel
Super + Q | Close focused window
Super + Shift + R | Reload Hyprland
Print | Screenshot using grim + slurp

Brightness and volume keys are handled via `brightnessctl` and `playerctl`.

## Troubleshooting

- Ensure `swww` and `ollama` are installed for wallpaper and color extraction.
- `fzf` is required for the wallpaper picker.
- If colors do not update, remove `~/.cache/theme` and re-run `theme_switcher.sh`.

