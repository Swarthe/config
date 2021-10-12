# play arguments if passed; play from preset directory otherwise
function mus --wraps='mpv $HOME/audio/selection/' --description 'Play audio'
    if [ (count $argv) -eq 0 ]
        printf '[file] %s\n' "Playing from: $HOME/audio/selection/"
        mpv --shuffle --no-video --term-osd-bar \
        --display-tags=Artist,Album,Composer,Date,Genre,Performer,Rating \
        $HOME/audio/selection/
    else
        mpv --shuffle --no-video --term-osd-bar \
        --display-tags=Artist,Album,Composer,Date,Genre,Performer,Rating \
        $argv;
    end
end
