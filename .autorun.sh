#!/usr/bin/zsh

function run() {
    if ! pgrep $1 
    then
        "$@"
    fi
}

function try_run() {
    if [[ `which $1 &> /dev/null && $?` != 0 ]]
    then
        run "$@"
    fi
}

try_run /usr/lib/polkit-kde-authentication-agent-1
try_run /usr/lib/policykit-1-gnome/polkit-gnome-authentification-agent-1

run dunst
run picom -b
run nitrogen --restore
#run nm-applet
#run blueman-applet
