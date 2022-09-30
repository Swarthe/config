# Naming is to stay consistent with shellsheck command
function ccheck --wraps='cppcheck' --description 'alias ccheck=cppcheck --enable=all --suppress=missingIncludeSystem'
  cppcheck --enable=all --suppress=missingIncludeSystem $argv;
end
