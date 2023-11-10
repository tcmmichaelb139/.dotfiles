#!/usr/bin/env bash

source "$HOME/.config/sketchybar/variables.sh" # Loads all defined colors

if [ "$SELECTED" = "true" ]; then
    sketchybar --animate tanh 5 --set $NAME \
        icon.color=$RED \
        icon="$SID" \
        icon.padding_left=10 \
        icon.padding_right=10 \
        background.padding_left=-5 \
        background.padding_right=-5 \
        # background.border_width=$BORDER_WIDTH \
        # background.border_color=$RED

else 
    sketchybar --animate tanh 5 --set $NAME \
        icon.color=$COMMENT \
        icon="$SID" \
        icon.padding_left=10 \
        icon.padding_right=10 \
        background.padding_left=-5 \
        background.padding_right=-5 \
        # background.border_width=$BORDER_WIDTH \
        # background.border_color=$COMMENT
fi




