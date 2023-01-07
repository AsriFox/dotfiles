#!/usr/bin/bash

config=$HOME/.config/hypr

# Notifications
dunst &

# Policykit
lxpolkit &

# Session
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &

# Waybar
waybar &

dunstify "Welcome back, $(whoami)!" &
