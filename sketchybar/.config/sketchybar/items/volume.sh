#!/usr/bin/env sh
#
sketchybar \
	--add item sound right \
	--set sound \
	update_freq=5 \
	icon.color=$BLACK \
	icon.padding_left=10 \
	label.color=$BLACK \
	label.padding_right=10 \
	background.color=$GREEN \
	background.height=26 \
	background.corner_radius=$CORNER_RADIUS \
	background.padding_right=5 \
	script="$PLUGIN_DIR/sound.sh"
