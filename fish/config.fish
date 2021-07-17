# Autostart X on TTY 1
if status -l && [ (tty) = /dev/tty1 ]
    startx
end

# Swap ctrl and capslock
setxkbmap -option "ctrl:swapcaps"
