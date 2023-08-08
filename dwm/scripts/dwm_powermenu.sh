#!/bin/bash


function powermenu {
	options="cancel\nshutdown\nrestart\nsleep"
	selected=$(echo -e $options | dmenu)
	if [[ $selected = "shutdown" ]]; then
		shutdown -h now
	elif [[ $selected = "restart" ]]; then
		reboot
	elif [[ $selected = "sleep" ]]; then
		systemctl suspend
	elif [[ $selected = "cancel" ]]; then
		return
	fi
}


powermenu

