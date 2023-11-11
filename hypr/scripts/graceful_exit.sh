#!/bin/bash
HC = $(hyprctl -j clients | jq -j '.[] | "hyprctl dispatch closewindow address:\(.address); "')
hyprctl --batch "$HC" 

case $1 in
  logout)
    hyprctl dispatch exit;;
    # exec loginctl terminate-user $USER;; 
  reboot)
    exec systemctl reboot;;
  shutdown)
    exec systemctl poweroff -i;;
esac

