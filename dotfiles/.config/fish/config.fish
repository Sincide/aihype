# Fish configuration
set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME $HOME/.config
set -g theme_file "$XDG_CONFIG_HOME/theme/colors.env"
if test -f "$theme_file"
    source "$theme_file"
end

# No greeting banner
set fish_greeting

# Common environment
set -gx EDITOR nvim

# Ensure scripts from this repo are in PATH only once
if not contains $HOME/.local/bin $PATH
    set -gx PATH $HOME/.local/bin $PATH
end
