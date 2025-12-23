#!/bin/bash
BRIGHTNESS_PATH="/sys/class/backlight/intel_backlight"
current=$(cat "$BRIGHTNESS_PATH/brightness")
max=$(cat "$BRIGHTNESS_PATH/max_brightness")
echo $(( current * 100 / max ))
