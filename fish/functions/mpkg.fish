function mpkg --wraps='makepkg' --description 'alias makepkg -sir'
  makepkg -sir $argv; 
end
