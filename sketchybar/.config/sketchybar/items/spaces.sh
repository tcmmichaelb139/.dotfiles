#!/usr/bin/env bash

# SPACE_ICONS=("" "" "" "" "" "" "" "" "" "")
# SPACE_ICONS=("一" "二" "三" "四" "五" "六" "七" "八" "九" "十")
SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")

SPACE_CLICK_SCRIPT='yabai -m space --focus $SID 2>/dev/null'

sketchybar --add item spacer.1 left \
    --set spacer.1 background.drawing=off \
        label.drawing=off \
        icon.drawing=off \
        width=10 \

for i in "${!SPACE_ICONS[@]}"; do
	sid=$(($i + 1))
	sketchybar --add space space.$sid left \
		--set space.$sid associated_space=$sid \
        label.drawing=off \
		script="$PLUGIN_DIR/space.sh" \
		click_script="$SPACE_CLICK_SCRIPT"
done

sketchybar --add item spacer.2 left \
    --set spacer.2 background.drawing=off \
        label.drawing=off \
        icon.drawing=off \
        width=5

sketchybar --add bracket spaces '/space.*/'             \
           --set         spaces background.border_width=$BORDER_WIDTH \
                                background.border_color=$RED \
                                background.corner_radius=$CORNER_RADIUS  \
                                background.color=$BAR_COLOR \
                                background.height=26 \
                                background.color=$BAR_COLOR \
                                background.drawing=on


sketchybar --add item separator left \
	--set separator icon= \
	icon.font="$FONT:Regular:16.0" \
	background.padding_left=26 \
	background.padding_right=15 \
	label.drawing=off \
	associated_display=active \
	icon.color=$YELLOW
