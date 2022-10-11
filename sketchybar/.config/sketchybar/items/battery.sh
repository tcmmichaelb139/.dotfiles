#!/usr/bin/env sh

sketchybar --add item battery right \
    --set battery \
    update_freq=3 \
    icon.color=$CYAN \
    script="$PLUGIN_DIR/power.sh"
