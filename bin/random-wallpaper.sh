#!/usr/bin/bash

monitor=`hyprctl monitors | grep Monitor | awk '{print $2}'`

wall_dir="$HOME/pictures/wallpapers"

wall_file=$(find "$wall_dir" -type f -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" | shuf -n 1)
cp $wall_file ~/.cache/wp.png
hyprctl hyprpaper unload all
hyprctl hyprpaper preload $wall_file
hyprctl hyprpaper wallpaper "$monitor, $wall_file"
