#!/usr/bin/env bash

COLOR=$GREEN

media=(
    scroll_texts=on
    icon= 
    icon.color=$COLOR
	icon.padding_left=10
    script="$PLUGIN_DIR/spotify.sh"
    background.color=$BAR_COLOR
    background.height=26
    background.corner_radius=$CORNER_RADIUS
    background.border_width=$BORDER_WIDTH
    background.border_color=$COLOR
    background.padding_right=-5
    background.drawing=on
    label.padding_right=10
    label.max_chars=23
    associated_display=active 
    updates=on
)

sketchybar --add item media q \
           --set media "${media[@]}" \
           --subscribe media media_change

