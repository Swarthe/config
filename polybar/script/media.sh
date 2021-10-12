#!/usr/bin/sh
#
# media.sh: Show MPRIS media status
#

printf_media ()
{
    playerctl metadata -f \
    "{{artist}}   $1   {{trunc(title, 75)}}   ({{duration(position)}} / {{duration(mpris:length)}})"
}

if [ "$(playerctl status 2> /dev/null)" = "Playing" ]; then
    printf_media ""
elif [ "$(playerctl status 2> /dev/null)" = "Paused" ]; then
    printf_media ""
else
    printf '\n'
fi
