#!/usr/bin/sh
#
# update.sh: Show number of available package updates from the official
#            repository and AUR
#

get_log_time ()
{
    stat -c %Y /var/log/pacman.log
}

# refresh polybar ipc
if [ "$1" = "-r" ]; then
    while pgrep polybar; do
        log_time=$(get_log_time)
        sleep 5
        if [ $log_time -ne $(get_log_time) ]; then
            polybar-msg hook update-ipc 1
        fi
    done
    exit 0
fi

updates_repo=$(checkupdates | wc -l)
updates_aur=$(yay -Qum | wc -l)

if [ $(($updates_repo + $updates_aur)) -eq 0 ]; then
    echo
else
    echo "%{F#e60053}%{F-} $updates_repo | $updates_aur"
fi
