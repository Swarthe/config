# The name comes from an older AUR helper
function yay --wraps='paru -S' --description 'alias yay=paru'
    paru $argv
end
