# Original:
# <https://github.com/stefanvanburen/dotfiles/blob/9e62163c674f3fef58a12d752daa78b4c5eeecbe/config.fish#L65-L125>

function unar --description "Extract files from archives"
    # no arguments, write usage
    if [ (count $argv) -eq 0 ] || [ $argv[1] = "-h" ] || [ $argv[1] = "--help" ]
        printf '%s\n' "Usage: unar [OPTION]... [FILE]..." >&2
        printf '%s\n' "Extract files from archives." >&2
        printf '%s\n' "Options:" >&2
        printf '%s\n' "  -r, --remove    remove archive after unpacking" >&2
        return 1
    end

    if [ $argv[1] = "-r" ] || [ $argv[1] = "--remove" ]
        set -l remove_file 1
        set --erase argv[1]
    end

    for i in $argv[1..-1]
        if [ ! -f $i ]
            printf 'unar: %s\n' "'$i' is not a valid file" >&2
            continue
        end

        set -l extension (string match -r ".*(\.[^\.]*)\$" $i)[2]
        switch $extension
            case '*.tar.gz' '*.tgz'
                tar x || tar zxf "$i"
            case '*.tar.bz2' '*.tbz' '*.tbz2'
                tar xjf "$i"
            case '*.tar.xz' '*.txz'
                tar --xz -xf "$i" || xzcat "$i" | tar xf -
            case '*.tar.zma' '*.tlz'
                tar --lzma -xf "$i" || lzcat "$i" | tar xf -
            case '*.tar'
                tar xvf "$i"
            case '*.gz'
                gunzip -k "$i"
            case '*.bz2'
                bunzip2 "$i"
            case '*.xz'
                unxz "$i"
            case '*.lzma'
                unlzma "$i"
            case '*.z'
                uncompress "$i"
            case '*.zip' '*.war' '*.jar' '*.sublime-package' '*.ipsw' '*.xpi' '*.apk' '*.aar' '*.whl'
                set -l extract_dir (string match -r "(.*)\.[^\.]*\$" $i)[2]
                unzip "$i" -d $extract_dir
            case '*.rar'
                unrar x -ad "$i"
            case '*.7z'
                7za x "$i"
            case '*'
                printf 'unar: %s\n' "'$i' cannot be extracted" >&2
                set -l fail 1
        end

        if [ -z $fail ] && [ -n $remove_file ]
            rm $i
        end
    end
end
