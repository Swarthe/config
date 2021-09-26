#!/usr/bin/sh
#
# microphone.sh: Show status of the microphone
#

is_muted ()
{
    pactl list sources \
        | grep -FA 10 alsa_input.usb-SteelSeries_SteelSeries_Arctis_7-00.mono-chat \
        | grep -Fq "Mute: yes"
}

is_used ()
{
    grep -Fq "owner_pid" /proc/asound/card2/pcm0c/sub0/status
}

# Red if microphone is claimed by process
if is_muted && is_used; then
    echo "%{F#e60053}%{F-}"
elif is_muted; then
    echo ""
elif is_used; then
    echo "%{F#e60053}%{F-}"
else
    echo
fi
