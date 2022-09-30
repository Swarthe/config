#!/usr/bin/sh
#
# menu.sh: Show various complex menus with rofi
#

if [ "$1" = '-q' ]; then
    # Query the internet with tweaked rofi and tuxi
    rofi -show query \
    -theme-str '* { selected-normal-background: @background; }' \
    -theme-str '* { selected-normal-foreground: @foreground; }' \
    -theme-str '* { alternate-normal-background: @background; }' \
    -theme-str 'listview { spacing: 0px; }'
elif [ "$1" = '-d' ]; then
    # Drag and drop files with dragon and file-browser-extended
    rofi -show file-browser-extended -file-browser-cmd \
    'dragon-drop -x' -display-file-browser-extended 'drag'
fi
