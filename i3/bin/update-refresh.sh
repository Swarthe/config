#!/usr/bin/sh
#
# update-refresh.sh: Monitor pacman and operations and refresh the polybar
#                    update indicator
#

get_log_time ()
{
    stat -c %Y /var/log/pacman.log
}

while pgrep -u "$USER" polybar; do
    log_time=$(get_log_time)
    sleep 5

    if [ $log_time -ne $(get_log_time) ]; then
        polybar-msg hook update-ipc 1
    fi
done
