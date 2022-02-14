#!/bin/sh
res=$(dmenu -p "Power Menu:"< "$HOME"/dots/bar/options)
if [[ $res = "Lock" ]]; then
    i3lock-fancy-rapid 10 10
fi
if [[ $res = "Logout" ]]; then
    killall i3
fi
if [[ $res = "Suspend" ]]; then
    systemctl suspend
fi
if [[ $res = "Restart" ]]; then
    systemctl reboot
fi
if [[ $res = "Shutdown" ]]; then
    systemctl poweroff
fi
exit 0
