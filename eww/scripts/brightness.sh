#!/bin/bash

BRIGHTNESS_PATH="/sys/class/backlight/intel_backlight"

case "$1" in
    get)
        current=$(cat "$BRIGHTNESS_PATH/brightness")
        max=$(cat "$BRIGHTNESS_PATH/max_brightness")
        echo $(( current * 100 / max ))
        ;;
    set)
        value=$(printf "%.0f" "$2")

        if [ "$value" -lt 1 ]; then value=1; fi
        if [ "$value" -gt 100 ]; then value =100; fi
        max=$(cat "$BRIGHTNESS_PATH/max_brightness")
        new=$(( value * max / 100 ))

        echo "$new" | sudo tee "$BRIGHTNESS_PATH/brightness" >/dev/null
        ;;
esac
