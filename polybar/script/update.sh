#!/usr/bin/sh
#
# update.sh: Show number of available pacman and AUR package updates
#

# refresh polybar ipc
if [ "$1" = "-r" ]; then
    while pgrep polybar; do
        log_size=$(du -b /var/log/pacman.log | cut -f 1)
        sleep 5
        if [ $log_size -ne $(du -b /var/log/pacman.log | cut -f 1) ]; then
            polybar-msg hook update-ipc 1
        fi
    done
    exit
fi

updates_repo=$(checkupdates | wc -l)
updates_aur=$(yay -Qum | wc -l)

if [ $(($updates_repo + $updates_aur)) -eq 0 ]; then
    echo " "
else
    echo "%{F#e60053}%{F-} $updates_repo | $updates_aur"
fi
