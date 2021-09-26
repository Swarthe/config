function mus --wraps='mpv $HOME/audio/selection/' --description \
    'alias mpv --shuffle --no-video --term-osd-bar $HOME/audio/selection/'
    if [ (count $argv) -eq 0 ]
        printf '[file] %s\n' "Playing from: $HOME/audio/selection/"
        mpv --shuffle --no-video --term-osd-bar $HOME/audio/selection/
    else
        mpv --shuffle --no-video --term-osd-bar $argv;
    end
end
