# Fish configuration
set -g theme_file ~/.cache/theme/colors.env
if test -f $theme_file
    source $theme_file
end

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# No greeting banner
set fish_greeting

# Common environment
set -gx EDITOR nvim

function fish_prompt
    set_color $accent
    echo -n (prompt_pwd) '>'
    set_color normal
end

# Ensure scripts from this repo are in PATH
set -gx PATH $PATH $HOME/.local/bin

# Convenience functions
function theme-toggle
    toggle_theme.sh
end

function wall-random
    random_wallpaper.sh
end
