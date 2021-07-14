#!/usr/bin/sh
#
# microphone.sh: Show number of processes accessing the microphone
#

if ! grep "owner_pid" /proc/asound/card2/pcm0c/sub0/status &> /dev/null; then
    echo ""
else
    echo -e "%{F#e60053}%{F-}"
fi
