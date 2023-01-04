#!/usr/bin/env sh
#
sketchybar \
    --add item sound right \
    --set sound \
    update_freq=5 \
    icon.color=$ORANGE \
    background.color=$BLACK \
    background.height=26 \
    background.corner_radius=$CORNER_RADIUS \
    icon.padding_left=10 \
    label.padding_right=10 \
    script="$PLUGIN_DIR/sound.sh"
