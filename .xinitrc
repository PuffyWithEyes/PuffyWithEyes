#!/bin/bash

emacs --daemon &
flameshot &
setxkbmap -layout us,ru -option grp:shifts_toggle
feh --bg-fill ~/.config/dwm/wallpapers/luzhajka_les_gory_144578_1920x1080.jpg &
bash /home/puffy/.config/dwm/scripts/dwm_time.bash & 
exec dwm
