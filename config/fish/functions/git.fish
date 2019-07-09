# Wrap git automatically by adding the following to ~/.config/fish/functions/git.fish:

function git --description 'Alias for hub, which wraps git to provide extra functionality with GitHub.'
    if hash hub
        command hub $argv
    else
        command git $argv
    end
end
