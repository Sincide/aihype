# Dotfiles Overview

The `dotfiles` directory holds configuration files for all components of the desktop. They are intended to be managed with `stow` so the structure mirrors `~/.config`.

## Fish shell

`config.fish` loads theme variables from `~/.cache/theme/colors.env`, defines a custom prompt and a few aliases.

## Dunst

The `dunstrc` file styles notifications and sets timeouts. Colors are substituted from the current theme on login.

## Fuzzel

The launcher configuration sets font, width and prompt options under `[main]`.

## Hyprland

- `hyprland.conf` contains global compositor settings and includes keybindings and autostart scripts.
- `bindings/keys.conf` lists keybindings.
- `autostart/start.sh` starts services like `swww`, `dunst` and `waybar`.

## Kitty

`kitty.conf` pulls in colors from `~/.cache/theme/kitty.conf` and tweaks window behaviour.

## Waybar

A JSON configuration and accompanying `style.css` control the status bar. `colors.css` is kept in sync with the generated theme by `apply_colors.sh`.
