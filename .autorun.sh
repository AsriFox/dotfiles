#!/bin/sh

run() {
    if ! pgrep $1 
    then
        "$@"
    fi
}

#try_run /usr/lib/polkit-kde-authentication-agent-1
#try_run /usr/lib/policykit-1-gnome/polkit-gnome-authentification-agent-1

dunst &

polkit=/usr/lib/lxpolkit/lxpolkit
{ command -v $polkit && \
    { pgrep $polkit || $polkit & } } || \
    dunstify "Couldn't find lxpolkit!"

picom -b &
nitrogen --restore
#run nm-applet
#run blueman-applet
