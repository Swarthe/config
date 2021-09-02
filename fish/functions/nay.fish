function nay --wraps='pacman -Rns' --description 'alias nay=sudo pacman -Rns'
    sudo pacman -Rns $argv
end
