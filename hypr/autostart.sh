#!/bin/sh

# Notifications
mako &

# Policykit
/usr/lib/polkit-kde-authentication-agent-1 &
# lxpolkit &

# Session
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &

# NetworkManager
nm-applet &

# Wallpaper - image
swww init && swww img -o DP-1 /home/asrifox/Pictures/wallpapers/1661259266192956689.jpg &

# Wallpaper - video
sleep 2 && mpvpaper -o "no-audio video-zoom=1024/1920 loop-file=inf" DP-2 /home/asrifox/Pictures/wallpapers/YaeWallpaper.mp4 &

# eww bar
~/.local/bin/eww daemon && ~/.local/bin/eww open bar &

# cliphist
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &

notify-send "Welcome back, $(whoami)!" -t 3000 &
