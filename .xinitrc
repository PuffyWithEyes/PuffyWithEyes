#!/bin/bash

emacs --daemon
setxkbmap -layout us,ru -option grp:shifts_toggle
feh --bg-fill Downloads/1637780133_73-gamerwall-pro-p-oboi-zakat-minimalizm-oboi-na-rabochii-sto-79.jpg &
bash /home/puffy/.config/dwm/scripts/dwm_time.bash & 
exec dwm
