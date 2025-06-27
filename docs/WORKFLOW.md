# Workflow

This guide explains how the pieces of the repository work together.

1. **Install**
   - Clone the repository and run `./install.sh`.
   - Packages are installed and dotfiles are symlinked using `stow`.
   - All helper scripts are linked to `~/.local/bin` so they are available in your `$PATH`.
   - A default theme is copied to `~/.config/themes/colors.json` and `apply_colors.sh` generates fragments used by the configs.

2. **Theming**
   - `theme_switcher.sh /path/to/image.jpg` sets the wallpaper and uses a local LLM via `ollama` to create a palette. The palette is saved to `~/.config/themes/colors.json` and `apply_colors.sh` updates fragments.
   - `toggle_theme.sh` quickly switches between the built in light and dark themes without contacting the LLM.
   - Generated fragments are stored under `~/.cache/theme/` and sourced by Hyprland, Waybar, Kitty, Dunst and Fuzzel.

3. **Wallpaper Management**
   - `wallpaper_picker.sh` provides an interactive picker with previews.
   - `random_wallpaper.sh` applies a random image from your wallpaper directory and generates a matching palette.

4. **Autostart**
   - When Hyprland launches it executes `autostart/start.sh` which starts required services, loads Waybar and reapplies the current theme.

5. **Keybindings**
   - Super+T toggles the preset theme.
   - Super+P opens the wallpaper picker.
   - Number keys switch workspaces, while Super+Shift moves the focused window.

Together these components provide a lightweight but flexible Wayland desktop with dynamic theming.
