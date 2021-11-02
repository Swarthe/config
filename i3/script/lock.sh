#!/usr/bin/sh
#
# lock.sh: Securely lock the display with i3lock-color
#

# Pause dunst while locked to not show notifications.
pkill -u "$USER" -USR1 dunst
i3lock --nofork --indicator --clock --fill \
--greeter-text="$USER" --time-str='%H:%M' --date-str='%a %d %b' \
--verif-text='Verifying...' --wrong-text='Incorrect!' --noinput-text='No Input' \
--{date,time,greeter}-color=ffeeeeee --ring-width 5 --color=00000000 \
--image="$(find $HOME/image/selection/good/background/spatial -type f | shuf -n 1)" \
--ring-color=2062b0 --ringver-color=009900 --keyhl-color=63a5f3 \
--insidever-color=009900ff
pkill -u "$USER" -USR2 dunst
# Unpause dunst when unlocked to show notifications, even those sent while
# locked.
