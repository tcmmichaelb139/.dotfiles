#!/usr/bin/env sh

sketchybar --add item cpu right \
	--set cpu \
	update_freq=3 \
	icon.color=$BLACK \
	icon.padding_left=10 \
	icon.font="$FONT:Bold:16.0" \
	label.color=$BLACK \
	label.padding_right=10 \
	background.color=$YELLOW \
	background.height=26 \
	background.corner_radius=$CORNER_RADIUS \
	background.padding_right=5 \
	script="$PLUGIN_DIR/cpu.sh"
