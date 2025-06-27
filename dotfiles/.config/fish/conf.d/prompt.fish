function fish_prompt
    set_color $accent
    echo -n (prompt_pwd)
    __fish_git_prompt
    echo -n '> '
    set_color normal
end
