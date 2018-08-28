#!/bin/sh
# shell script to prepend i3status with more stuff

while true; do
        #weather=$(weather-util KIGX | grep Temp)
        home=$(df -h | awk '/\/dev\/sda1/ {printf "Boot: %s", $5}')
        # home=$(df -h | awk '/\/dev\/sda4/ {printf "Home: %s", $5}')
        now=$(date +%Y-%m-%d\ %I:%M:%S)
        cpu=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')
        mem=$(free | grep Mem | awk '{printf "%.2f", ($3/$2 * 100.0)}')
        wifi=$(iwconfig wlp3s0 | awk '/Signal\ level/ {printf "%s %s", $3, $4}' | sed 's:[a-zA-Z\ ]*=::')
        rxtx=$(ifconfig wlp3s0 | grep 'bytes' | awk '/RX/ {printf "R: %s %s T: %s %s", $3, $4, $7, $8}')
        battery=$(acpi -b | awk '{printf "Battery: %s", $4}')
        echo " $home  |  $rxtx  |  CPU: $cpu  |  Mem(used): $mem%  |  Signal: $wifi  |  $now  |  $battery" || exit 1
        sleep 2s
done