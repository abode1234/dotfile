#!/bin/bash

options="󰌾  Lock\n󰍃  Logout\n󰤄  Suspend\n󰜉  Reboot\n󰐥  Shutdown"

chosen=$(echo -e "$options" | rofi -dmenu -p "  Power Menu" -theme ~/.config/rofi/power-menu.rasi)

case "$chosen" in
    "󰌾  Lock")
        hyprlock || swaylock
        ;;
    "󰍃  Logout")
        hyprctl dispatch exit
        ;;
    "󰤄  Suspend")
        systemctl suspend
        ;;
    "󰜉  Reboot")
        systemctl reboot
        ;;
    "󰐥  Shutdown")
        systemctl poweroff
        ;;
esac
