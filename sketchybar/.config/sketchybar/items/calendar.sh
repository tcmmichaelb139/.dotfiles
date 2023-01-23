#!/usr/bin/env sh

sketchybar --add item calendar right \
	--set calendar update_freq=15 \
	icon.color=$BLACK \
	icon.padding_left=10 \
	label.color=$BLACK \
	label.padding_right=10 \
	script="$PLUGIN_DIR/calendar.sh" \
	background.height=26 \
	background.color=$BLUE \
	background.corner_radius=$CORNER_RADIUS \
	background.padding_right=5
