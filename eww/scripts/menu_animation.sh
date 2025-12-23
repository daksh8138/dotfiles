#!/bin/bash

# 1. Force the slider to "Closed" position (Invisible)
eww update menurev=false

# 2. Open the window (It will appear instantly now, but empty/transparent)
eww open menuctl

# 3. Wait 0.05s for the window to actually render on screen
sleep 0.2

# 4. Trigger the slide animation (Blue part slides in)
eww update menurev=true
