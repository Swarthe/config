#!/usr/bin/sh
#
# update.sh: Show number of available package updates using paru and
#            checkupdates
#

updates_repo=$(checkupdates | wc -l)
updates_aur=$(paru -Qum | wc -l)

if [ $(($updates_repo + $updates_aur)) -eq 0 ]; then
    printf '\n'
else
    printf '%s %d | %d\n' '%{F#e60053}%{F-}' "$updates_repo" "$updates_aur"
fi
