#!/usr/bin/env bash

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")

sketchybar --add item spacer.1 left \
	--set spacer.1 background.drawing=off \
	label.drawing=off \
	icon.drawing=off \
	width=10

for i in {0..9}; do
	sid=$((i + 1))
	sketchybar --add space space.$sid left \
		--set space.$sid associated_space=$sid \
		label.drawing=off \
		icon.padding_left=10 \
		icon.padding_right=10 \
		background.padding_left=-5 \
		background.padding_right=-5 \
		script="$PLUGIN_DIR/space.sh"
done

sketchybar --add item spacer.2 left \
	--set spacer.2 background.drawing=off \
	label.drawing=off \
	icon.drawing=off \
	width=5

sketchybar --add bracket spaces '/space.*/' \
	--set spaces background.border_width="$BORDER_WIDTH" \
	background.border_color="$RED" \
	background.corner_radius="$CORNER_RADIUS" \
	background.color="$BAR_COLOR" \
	background.height=26 \
	background.drawing=on

sketchybar --add item separator left \
	--set separator icon= \
	icon.font="$FONT:Regular:16.0" \
	background.padding_left=26 \
	background.padding_right=15 \
	label.drawing=off \
	associated_display=active \
	icon.color="$YELLOW"
