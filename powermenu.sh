#!/bin/bash
res=$(dmenu -p "Power Menu:"< /home/void/dots/bar/options)
if [[ $res = "Lock" ]]; then
    slock
fi
if [[ $res = "Logout" ]]; then
    xdotool key super+shift+'c'
fi
if [[ $res = "Suspend" ]]; then
    suspend
fi
if [[ $res = "Restart" ]]; then
    reboot
fi
if [[ $res = "Shutdown" ]]; then
    poweroff
fi
exit 0
