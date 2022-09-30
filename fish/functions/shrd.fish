function shrd --wraps='shred -uz' --description 'alias shrd=shred -uz'
  shred -uzn 7 $argv;
end
