#!/bin/bash


function time_func {
	while true
	do
		date_time=$(date +"%H:%M %d.%m %A")
		cpu_temp=$(sensors | grep "Core 0" | cut -d'+' -f2 | cut -c1-2)
		mem_use=$(free | awk '/Mem/{printf("%d"), $3/$2 * 100.0}')
		
		if [ "$cpu_temp" -gt 75 ]; then
			cpu_temp="^c#FF0000^$cpu_temp°^d^"
		elif [ "$cpu_temp" -gt 50 ]; then
			cpu_temp="^c#FFFF00^$cpu_temp°^d^"
		elif [ "$cpu_temp" -gt 15 ]; then
			cpu_temp="^c#00FF00^$cpu_temp°^d^"
		else
			cpu_temp="^c#0000FF^$cpu_temp°^d^"
		fi

		if [ "$mem_use" -gt 75 ]; then
			mem_use=$(free | awk '/Mem/{printf("%.2f"), $3/$2 * 100.0}')
			mem_use="^c#FF0000^$mem_use%^d^"
		elif [ "$mem_use" -gt 50 ]; then
			mem_use=$(free | awk '/Mem/{printf("%.2f"), $3/$2 * 100.0}')
			mem_use="^c#FFFF00^$mem_use%^d^"
		elif [ "$mem_use" -gt 15 ]; then
			mem_use=$(free | awk '/Mem/{printf("%.2f"), $3/$2 * 100.0}')
			mem_use="^c#00FF00^$mem_use%^d^"
		else
			mem_use=$(free | awk '/Mem/{printf("%.2f"), $3/$2 * 100.0}')
			mem_use="^c#0000FF^$mem_use%^d^"
		fi
		
		xsetroot -name "MEM: $mem_use | CPU: $cpu_temp | $date_time"
		sleep 10s
	done
}


time_func

