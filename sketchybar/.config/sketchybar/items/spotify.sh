#!/usr/bin/env sh

sketchybar --add item spot_logo left \
    --set spot_logo icon= \
    label.drawing=off \
    icon.color=$BLACK \
    background.color=$GREEN \
    background.corner_radius=$CORNER_RADIUS

sketchybar --add item spot left \
    --set spot update_freq=1 \
    label.padding_left=10 \
    label.padding_right=10 \
    icon.drawing=off \
    updates=on \
    script="$PLUGIN_DIR/spotify.sh" \
    background.color=$BLACK \
    background.corner_radius=$CORNER_RADIUS \
    background.padding_left=0 \
    width=100
