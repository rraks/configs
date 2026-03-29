#!/bin/bash

FILE=~/Videos/screenrecording/record-$(date +%F_%T).mp4
REGION=$(slurp) || exit

echo "$i" | rofi -dmenu \
  -theme-str 'window {location: center; anchor: center; width: 200px;} listview {lines: 1;} element-text {font: "JetBrainsMono Nerd Font 48";}' \
  -no-config -no-lazy-grab >/dev/null

sleep 0.5

wf-recorder -g "$REGION" -f "$FILE"

# Safety net: kill after 10 minutes
(
  sleep 600
  if ps -p $REC_PID >/dev/null; then
    kill $REC_PID
    notify-send "Recording stopped (10 min limit)"
  fi
) &

wait $REC_PID
