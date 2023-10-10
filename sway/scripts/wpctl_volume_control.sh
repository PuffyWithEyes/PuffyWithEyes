#!/bin/sh
msgTag="VOL"

if [[ "$@" == "mute-toggle" ]]; then
	wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
else
	wpctl set-volume @DEFAULT_AUDIO_SINK@ "$@"
fi

# Query amixer for the current volume and whether or not the speaker is muted
volume="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2*100}')"
mute="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $3}')"

if [[ $volume == 0 || "$mute" == "[MUTED]" ]]; then
    # Show the sound muted notification
    dunstify -a "changeVolume" -u low -i audio-volume-muted -h string:x-dunst-stack-tag:$msgTag "Muted"
else
    # Show the volume notification
    dunstify -a "changeVolume" -u low -i audio-volume-high -h string:x-dunst-stack-tag:$msgTag \
    -h int:value:"$volume" "Volume: ${volume}"
fi

# Play the volume changed sound
canberra-gtk-play -i audio-volume-change -d "changeVolume"
