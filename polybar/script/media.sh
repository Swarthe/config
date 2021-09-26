#!/usr/bin/sh
#
# media.sh: Show MPRIS media status
#

printf_media ()
{
    playerctl metadata -f "{{artist}}   $*   {{title}}" \
    | sed -e 's/ - Topic//g' -e 's/\.[^.]*$//'
}

if [ "$(playerctl status 2> /dev/null)" = "Playing" ]; then
    printf_media ""
elif [ "$(playerctl status 2> /dev/null)" = "Paused" ]; then
    printf_media ""
else
    echo
fi
