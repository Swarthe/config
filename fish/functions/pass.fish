# Pass string argument to grep from passwords
# gpg file argument is an encrypted file with login information
function pass --wraps='gpg -d $HOME/document/utility/ssf.gpg' --description 'alias gpg -d $HOME/document/utility/ssf.gpg'
    if [ (count $argv) -eq 0 ]
        gpg -d $HOME/document/utility/ssf.gpg;
    else
        gpg -d $HOME/document/utility/ssf.gpg | grep -i "$argv"
    end
end
