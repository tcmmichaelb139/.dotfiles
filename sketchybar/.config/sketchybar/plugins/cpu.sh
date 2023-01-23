#!/usr/bin/env sh

sketchybar --set $NAME icon="" label="$(ps -A -o %cpu | awk '{s+=$1} END {print s "%"}')"
