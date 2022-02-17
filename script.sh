#!/bin/bash
print_power() {
    status="$(cat /sys/class/power_supply/ACAD/online)"
    battery="$(cat /sys/class/power_supply/BAT1/capacity)"
    if [ "${status}" == 1 ]; then
        echo -ne "CHR ${battery}%";
    else
        echo -ne "DIS ${battery}%";
    fi
}
print_cpuram() {
	CPURAM=$(echo "CPU `LC_ALL=C top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}'`% | RAM `free -m | awk '/Mem:/ { printf("%3.1f%%", $3/$2*100) }'`")
	echo -ne "$CPURAM";
}
print_volume() {
	mix="$(pulsemixer --get-mute)"
	vol="$(pulsemixer --get-volume)"
	if [[ $mix == "1" ]]; then
		echo -ne "MUT";
	elif [[ $mix == "0" ]]; then
		echo -ne "VOL ${vol}";
	fi
}
print_date() {
	date="$(LC_ALL=C date "+%a %d %b")"
	echo -ne "${date}";
}
print_backlight() {
	bl="$(xbacklight -get)"
	echo -ne "BL ${bl}%";
}
print_time() {
	time="$(date +"%I:%M %p")"
	echo -ne "${time}";
}
print_connection() {
	if [[ "$(nmcli | grep " connected" | wc -l)" -gt 0 ]]; then echo -ne "ONLINE"; else echo "OFFLINE"; fi
}
while true; do
	xsetroot -name "$(print_cpuram) | $(print_backlight) | $(print_power) | $(print_volume) | $(print_date) $(print_time)"
	sleep 1;
done 
