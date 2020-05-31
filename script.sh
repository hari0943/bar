#!/bin/bash
print_power() {
    status="$(cat /sys/class/power_supply/AC/online)"
    battery="$(cat /sys/class/power_supply/BAT0/capacity)"
    if [ "${status}" == 1 ]; then
        echo -ne "CHR ${battery}%";
    else
        echo -ne "DIS ${battery}%";
    fi
}
print_cpuram() {
	CPURAM=$(echo "CPU `LC_ALL=C top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}'`% | RAM `free -m | awk '/Mem:/ { printf("%3.1f%%", $3/$2*100) }'`")
	echo -ne "$CPURAM";
	sleep 1;
}
print_volume() {
	mix=`amixer get Master | tail -1`
	vol="$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')"
	if [[ $mix == *\[off\]* ]]; then
		echo -ne "MUT";
	elif [[ $mix == *\[on\]* ]]; then
		echo -ne "VOL ${vol}%";
	fi
}
print_date() {
	date="$(LC_ALL=C date "+%a %d %b")"
	echo -ne "${date}";
}
print_time() {
	time="$(date +"%I:%M %p")"
	echo -ne "${time}";
}
print_connection() {
	if [[ "$(cat /sys/class/net/enp0s25/operstate)" == "up" || "$(cat /sys/class/net/wlp2s0/operstate)" == "up" ]]; then echo -ne "ONLINE"; else echo "OFFLINE"; fi
}
while true; do
	xsetroot -name "$(print_cpuram) | $(print_connection) | $(print_power) | $(print_volume) | $(print_date) $(print_time)"
	sleep 1;
done 
