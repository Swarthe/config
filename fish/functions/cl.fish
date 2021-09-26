function cs --wraps='cd' --description 'alias cs=cd && ls'
  cd $argv && ls
end
