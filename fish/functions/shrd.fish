function shrd --wraps='shred -uz' --description 'alias shrd=shred -uz'
  shred -uz $argv;
end
