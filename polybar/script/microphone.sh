#!/usr/bin/sh
#
# microphone.sh: Show the status of the microphone using pactl
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

# Red if microphone is claimed by a process
if is_muted && is_used; then
    printf '%s\n' "%{F#e60053}%{F-}"
elif is_muted; then
    printf '%s\n' ""
elif is_used; then
    printf '%s\n' "%{F#e60053}%{F-}"
else
    printf '\n'
fi
