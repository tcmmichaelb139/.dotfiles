#!/usr/bin/env sh

# Trigger the brew_udpate event when brew update or upgrade is run from cmdline
# e.g. via function in .zshrc

sketchybar -m --add item network_up right \
	--set network_up label.font="$FONT:Semibold:10.0" \
	icon.font="$FONT:Bold:10.0" \
	icon=􀆇 \
	icon.highlight_color=$BLUE \
	y_offset=5 \
	width=0 \
	update_freq=1 \
	script="$PLUGIN_DIR/network.sh" \
	\
	--add item network_down right \
	--set network_down label.font="$FONT:Semibold:10.0" \
	icon.font="$FONT:Bold:10.0" \
	icon=􀆈 \
	icon.highlight_color=$YELLOW \
	y_offset=-5 \
	update_freq=1
