# Fish configuration
set -g theme_file ~/.cache/theme/colors.env
if test -f $theme_file
    source $theme_file
end

alias ls='ls --color=auto'

# Ensure scripts from this repo are in PATH
set -gx PATH $PATH $HOME/.local/bin

# Convenience functions
function theme-toggle
    toggle_theme.sh
end

function wall-random
    random_wallpaper.sh
end
