#!/usr/bin/env sh

sketchybar --add item calendar right \
    --set calendar update_freq=15 \
    icon= \
    icon.color=$MAGENTA \
    icon.font="$FONT:Bold:12.0" \
    icon.padding_left=5 \
    icon.padding_right=5 \
    label.color=$BLUE \
    label.padding_left=5 \
    label.padding_right=5 \
    width=150 \
    align=center \
    script="$PLUGIN_DIR/time.sh" \
    background.height=26 \
    background.corner_radius=$CORNER_RADIUS \
    background.padding_left \
    background.padding_right=2
