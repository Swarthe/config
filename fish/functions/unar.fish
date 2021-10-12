# Original:
# <https://github.com/stefanvanburen/dotfiles/blob/9e62163c674f3fef58a12d752daa78b4c5eeecbe/config.fish#L65-L125>

function unar --wraps='tar' --description "Extract files from archives"
    # no arguments, write usage
    if [ (count $argv) -eq 0 ] || [ $argv[1] = "-h" ] || [ $argv[1] = "--help" ]
        printf '%s\n' "-r, --remove    remove archive after unpacking"
        return
    end

    if [ $argv[1] = "-r" ] || [ $argv[1] = "--remove" ]
        set remove_file 1
        set -e argv[1]
    end

    for i in $argv[1..-1]
        if [ ! -e $i ]
            printf 'unar: %s\n' "'$i' is not a valid file" >&2
            continue
        end

        switch $i
            case '*.tar.gz' '*.tgz'
                tar xv || tar zvxf "$i"
            case '*.tar.bz2' '*.tbz' '*.tbz2'
                tar xvjf "$i"
            case '*.tar.xz' '*.txz'
                tar --xz -xf "$i" || xzcat "$i" | tar xvf -
            case '*.tar.zma' '*.tlz'
                tar --lzma -xvf "$i" || lzcat "$i" | tar xvf -
            case '*.tar'
                tar xvf "$i"
            case '*.gz'
                gunzip -k "$i"
            case '*.bz2'
                bunzip2 "$i"
            case '*.xz'
                unxz -k "$i"
            case '*.lzma'
                unlzma "$i"
            case '*.z'
                uncompress "$i"
            case '*.zip' '*.war' '*.jar' '*.sublime-package' '*.ipsw' '*.xpi' \
                 '*.apk' '*.aar' '*.whl'
                set extract_dir (string match -r "(.*)\.[^\.]*\$" $i)[2]
                unzip "$i" -d $extract_dir
            case '*.rar'
                unrar x -ad "$i"
            case '*.7z'
                7za x "$i"
            case '*'
                printf 'unar: %s\n' "'$i' cannot be extracted" >&2
                set fail 1
        end

        if [ -z $fail ] && [ $remove_file ]
            rm $i
        end
    end
end
