#!/usr/bin/env sh
source "$HOME/.config/sketchybar/icons.sh"

ICON="󰅐"
LABEL=$(date '+%H:%M:%S')
sketchybar --set $NAME icon="$ICON" label="$LABEL"
