#!/bin/bash
# ~/.config/sway/scripts/lockman.sh

# Times the screen off and puts it to background
swayidle \
    timeout 150 'swaymsg "output * dpms off"' \
    resume 'swaymsg "output * dpms on"' &
# Locks the screen immediately
swaylock -c 550000 -k -i ~/.config/sway/lock.jpg --inside-color f7c1a7ff --ring-color 2d2725ff --line-color 463d39ff --inside-clear-color f7c1a7ff --inside-ver-color f7c1a7ff --ring-ver-color 2d2725ff
# Kills last background task so idle timer doesn't keep running
kill %%
