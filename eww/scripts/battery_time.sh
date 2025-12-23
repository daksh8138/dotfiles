#!/bin/bash

# 1. Try ACPI first (It is fast)
# We grab the time like 02:45:00 and cut it to 02:45
TIME=$(acpi -b | grep -o '[0-9]\{2\}:[0-9]\{2\}' | head -n1)

# 2. If ACPI failed (empty), try UPower (It is smarter)
if [ -z "$TIME" ]; then
    # Ask UPower for "time to empty" and format "2.5 hours" -> "2.5h"
    TIME=$(upower -i $(upower -e | grep BAT) | grep "time to empty" | awk '{print $4}' | sed 's/ hours/h/' | sed 's/ minutes/m/')
fi

# 3. Get Status (Charging/Discharging)
STATUS=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null | head -n1)

# 4. Final Output Logic
if [ "$STATUS" == "Charging" ]; then
    echo "⚡ Charging"
elif [ "$STATUS" == "Discharging" ]; then
    if [ -z "$TIME" ]; then
        # If both tools failed, it means the battery is still calculating
        echo "Measuring..." 
    else
        echo "$TIME left"
    fi
elif [ "$STATUS" == "Full" ]; then
    echo "Full"
else
    echo ""
fi
