function ccheck --wraps='cppcheck' --description 'alias ccheck=cppcheck --enable=all'
  cppcheck --enable=all $argv;
end
