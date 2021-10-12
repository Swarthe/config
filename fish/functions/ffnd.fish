function ffnd --wraps='find' --description 'Fuzzy file search'
  find . -iname "*$argv*";
end
