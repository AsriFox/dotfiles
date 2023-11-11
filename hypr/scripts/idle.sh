#!/bin/sh
swayidle \
timeout 300 '~/.config/hypr/scripts/lock.sh --grace 5' \
timeout 600 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' \
timeout 1800 'systemctl suspend' \
before-sleep '~/.config/hypr/scripts/lock.sh'
