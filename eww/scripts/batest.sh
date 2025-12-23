#!/bin/bash

BAT=$(upower -e | grep BAT)

while true; do
    INFO=$(upower -i "$BAT")

    STATUS=$(echo "$INFO" | grep "state" | awk '{print $2}')
    TIME=$(echo "$INFO" | grep -E "time to" | awk '{print $4 " " $5}')

    if [[ -z "$TIME" ]]; then
        echo "Calculating..."
    else
        echo "$TIME left"
    fi

    sleep 20
done
