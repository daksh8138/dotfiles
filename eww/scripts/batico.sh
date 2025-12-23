#!/bin/bash

get_icon(){
  case $1 in
    8[0-9]|9[0-9]|100)
      CLASS="BAT1"   # Green (Full)
      ICON=" "
      ;;
    6[0-9]|7[0-9])
      CLASS="BAT2"   # Green (High)
      ICON=" "
      ;;
    4[0-9]|5[0-9])
      CLASS="BAT3"   # Yellow (Medium)
      ICON=" "
      ;;
    2[0-9]|3[0-9])
      CLASS="BAT4"   # Orange (Low)
      ICON=" "
      ;;
    *)
      CLASS="BAT5"   # Red (Critical)
      ICON=" "
      ;;
  esac
}
while true; do
    BATTERY=$(cat /sys/class/power_supply/BAT0/capacity)
    STATUS=$(cat /sys/class/power_supply/BAT0/status)
    CLASS=""
    ICON=""
    get_icon "$BATTERY"

    if [[ "$STATUS" == "Charging" ]]; then
        CLASS="CHARGING"
    fi

    echo "(box :class \"$CLASS\" \"$ICON\")"
    sleep 1
done
