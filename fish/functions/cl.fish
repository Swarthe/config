function cl --wraps='cd && ls' --description 'alias cl=cd && ls'
  cd $argv && ls;
end
