#!/usr/bin/env sh

sketchybar \
    --add item front_app left \
    --set front_app script="$PLUGIN_DIR/front_app.sh" \
    icon.drawing=off \
    background.padding_left=0 \
    background.padding_right=10 \
    label.color=$WHITE \
    label.font="$FONT:Bold:15.0" \
    associated_display=active \
    --subscribe front_app front_app_switched
