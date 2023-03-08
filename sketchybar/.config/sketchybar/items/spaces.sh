#!/usr/bin/env bash

# SPACE_ICONS=("" "" "" "" "" "" "" "" "" "")
# SPACE_ICONS=("一" "二" "三" "四" "五" "六" "七" "八" "九" "十")
SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")

SPACE_CLICK_SCRIPT='yabai -m space --focus $SID 2>/dev/null'

for i in "${!SPACE_ICONS[@]}"; do
	sid=$(($i + 1))
	sketchybar --add space space.$sid left \
		--set space.$sid associated_space=$sid \
		icon=${SPACE_ICONS[i]} \
		icon.padding_left=22 \
		icon.padding_right=22 \
		icon.highlight_color=$RED \
		background.padding_left=-11 \
		background.padding_right=-11 \
		background.height=26 \
		background.corner_radius=$CORNER_RADIUS \
		background.color=$BAR_COLOR \
		background.drawing=on \
		label.background.drawing=on \
		label.padding_right=20 \
		label.drawing=off \
		script="$PLUGIN_DIR/space.sh" \
		click_script="$SPACE_CLICK_SCRIPT"
done

sketchybar --set space.1 background.padding_left=-1

sketchybar --add item separator left \
	--set separator icon= \
	icon.font="$FONT:Regular:16.0" \
	background.padding_left=26 \
	background.padding_right=15 \
	label.drawing=off \
	associated_display=active \
	icon.color=$YELLOW
