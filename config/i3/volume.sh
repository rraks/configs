#!/usr/bin/env bash

SINK=$(pactl list short sinks | grep RUNNING | cut -f1)

if [ "$SINK" == "" ]; then
  SINK="0"
fi

if [ "$1" != "M" ]; then
  pactl set-sink-volume "$SINK" "$1"
else
  pactl set-sink-mute "$SINK" toggle
fi
