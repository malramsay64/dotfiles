# Defined in - @ line 0
function pass --description 'alias pass=gopass'
    if hash gopass
        command gopass $argv
    else
        command pass $argv
    end
end
