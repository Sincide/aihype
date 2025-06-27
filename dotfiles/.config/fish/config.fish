# Fish configuration
set -g theme_file ~/.cache/theme/colors.env
if test -f $theme_file
    source $theme_file
end

alias ls='ls --color=auto'
