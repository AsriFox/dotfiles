#!/bin/sh

if pgrep polybar
then
    pkill polybar
fi

polybar --config=~/.config/polybar/config.ini top
