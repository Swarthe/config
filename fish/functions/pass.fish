# search arguments if passed in file; display entirely otherwise
# gpg file argument is an encrypted file with login information
function pass --wraps='gpg -d $HOME/document/utility/ssf.gpg' --description 'Display password information'
    if [ (count $argv) -eq 0 ]
        gpg -d $HOME/document/utility/ssf.gpg
    else
        gpg -d $HOME/document/utility/ssf.gpg | grep -i "$argv"
    end
end
