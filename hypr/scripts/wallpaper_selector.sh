#!/bin/bash

# Directory containing wallpapers
WALL_DIR="$HOME/Pictures/Wallpapers"

# Rofi Configuration (Grid View)
# This forces Rofi to look like a gallery
ROFI_CMD="rofi -dmenu -i -p 'Select Wallpaper' \
    -theme-str 'listview { columns: 4; lines: 3; }' \
    -theme-str 'element { orientation: vertical; padding: 10px; }' \
    -theme-str 'element-icon { size: 100px; }' \
    -theme-str 'element-text { vertical-align: 0.5; horizontal-align: 0.5; }'"

# 1. Get list of images
# 2. Format them for Rofi (Image Name + Icon Path)
# 3. Show Rofi
SELECTED=$(ls "$WALL_DIR" | while read -r img; do
    echo -en "$img\0icon\x1f$WALL_DIR/$img\n"
done | eval $ROFI_CMD)

# If a wallpaper was selected, apply it
if [ -n "$SELECTED" ]; then
    # Full path to image
    IMG_PATH="$WALL_DIR/$SELECTED"

    # Apply with Hyprpaper
    hyprctl hyprpaper unload all
    hyprctl hyprpaper preload "$IMG_PATH"
    hyprctl hyprpaper wallpaper ",$IMG_PATH"

    convert "$IMG_PATH" "$HOME/Pictures/Wallpapers/current_wallpaper.png"


    ## NEW
    eww reload

fi
