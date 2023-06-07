#!/usr/bin/bash
#
# volume.sh: Change the audio volume.
#
# Accepts one parameter of the form [+/-]AMOUNT%
# Example: volume.sh +10%
#

# Current volume as an integer.
vol () {
    local str=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{ print $5 }')
    echo "${str::-1}"       # Trim '%' symbol.
}

sign="${1:0:1}"         # Should be '+' or '-'.
offset="${1:1:-1}"      # Parse e.g. '+12%' into '12'.
new_vol=$(($(vol) $sign offset))

# Prevent a volume above 100%. `pactl` doesn't go below 0% anyway.
if [ "$sign" = '+' ]; then
    new_vol=$(($new_vol > 100 ? 100 : $new_vol))
fi

pactl set-sink-volume @DEFAULT_SINK@ "$new_vol"%
