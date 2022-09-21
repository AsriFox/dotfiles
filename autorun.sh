#!/usr/bin/zsh

function run() {
    if ! pgrep $1 
    then
        "$@"
    fi
}

run /usr/lib/policykit-1-gnome/polkit-gnome-authentification-agent-1 &
#run blueman-applet
run picom -b
run nitrogen --restore
run nm-applet
