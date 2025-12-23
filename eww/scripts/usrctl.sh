#!/bin/bash

if [[ -z $(eww active-windows | grep 'usrctl') ]]; then
    eww update ctlrev=true
    eww open usrctl

else
    eww update ctlrev=false
    (sleep 0.35 && eww close usrctl) &
disown
fi
