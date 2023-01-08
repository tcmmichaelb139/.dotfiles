#!/usr/bin/env sh

sketchybar --add event brew_update \
	--add item brew right \
	--set brew script="$PLUGIN_DIR/brew.sh" \
	icon=􀐛 \
	icon.padding_left=10 \
	label.padding_right=10 \
	background.color=$BLACK \
	background.height=26 \
	background.corner_radius=$CORNER_RADIUS \
	background.padding_right=3 \
	--subscribe brew brew_update
