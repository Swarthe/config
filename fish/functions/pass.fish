function pass --wraps='gpg -d document/utility/ssf.gpg' --description 'alias gpg -d document/utility/ssf.gpg'
  gpg -d document/utility/ssf.gpg $argv; 
end
