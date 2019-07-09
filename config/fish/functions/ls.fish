function ls
    if hash exa
        command exa $argv
    else
        command ls --color=auto $argv
    end
end
