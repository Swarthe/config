#!/usr/bin/sh
#
# update.sh: Show number of available package updates using paru and
#            checkupdates
#

get_log_time ()
{
    stat -c %Y /var/log/pacman.log
}

# refresh polybar ipc if pacman operations have occurred
if [ "$1" = '-r' ]; then
    while pgrep -u "$USER" polybar; do
        log_time=$(get_log_time)
        sleep 5
        if [ $log_time -ne $(get_log_time) ]; then
            polybar-msg hook update-ipc 1
        fi
    done
    exit
fi

updates_repo=$(checkupdates | wc -l)
updates_aur=$(paru -Qum | wc -l)

if [ $(($updates_repo + $updates_aur)) -eq 0 ]; then
    printf '\n'
else
    printf '%s %s   %s\n' "%{F#e60053}%{F-}" "$updates_repo" "$updates_aur"
fi
