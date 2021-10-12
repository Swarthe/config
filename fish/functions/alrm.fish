function alrm --wraps='sleep' --description 'Play audio after a specified time'
    if sleep $argv 2> /dev/null
        notify-send -u critical "alrm" "Alarm for $argv"
        paplay $HOME/audio/batch/surprise/ww2-air-raid-siren.opus
    else
        printf '%s\n' "specify a duration to wait (you can pass time units, like '3h')"
    end
end
