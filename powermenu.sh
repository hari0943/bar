#!/bin/sh
res=$(dmenu -p "Power Menu:"< /home/arch/dots/bar/options)
if [[ $res = "Lock" ]]; then
    slock
fi
if [[ $res = "Logout" ]]; then
    killall dwm
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
