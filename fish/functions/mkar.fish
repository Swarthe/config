function mkar --wraps='tar' --description 'Compress and archive files'
    # no arguments, write usage
    if [ (count $argv) -eq 0 ] || [ $argv[1] = "-h" ] || [ $argv[1] = "--help" ]
        printf '%s\n' "-r, --remove    remove original file(s) after compressing"
        return
    end

    if [ $argv[1] = "-r" ] || [ $argv[1] = "--remove" ]
        set remove_file 1
        set -e argv[1]
    end

    for i in $argv[1..-1]
        if [ ! -e $i ]
            printf 'mkar: %s\n' "'$i' is not a valid file" >&2
            continue
        end

        if ! tar -cJf "$i"".tar.xz" "$i"
            set fail 1
        end

        if [ -z $fail ] && [ $remove_file ]
            rm -r $i
        end
    end
end
