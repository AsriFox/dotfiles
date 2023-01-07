#!/bin/sh

run() {
    if ! pgrep $1 
    then
        "$@" &
    fi
}

run dunst &

#polkit=/usr/lib/polkit-kde-authentication-agent-1
#polkit=/usr/lib/policykit-1-gnome/polkit-gnome-authentification-agent-1
polkit="$(command -v lxpolkit)"
if [ -z "$polkit" ]
then
    dunstify "Couldn't find lxpolkit!"
else
    run $polkit
fi

run picom -b
run nitrogen --restore
#run nm-applet
#run blueman-applet
