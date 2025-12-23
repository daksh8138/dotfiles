#!/bin/bash

# 1. Get current state
state=$(eww get menurev)

if [ "$state" = "true" ]; then
    # === CLOSING ===
    # Trigger the slide-out animation immediately
    eww update menurev=false
    
    # Run the waiting part in the background (&) so EWW doesn't timeout!
    (sleep 0.4 && eww close menuctl) &

else
    # === OPENING ===
    eww open menuctl
    eww update menurev=true
fi
