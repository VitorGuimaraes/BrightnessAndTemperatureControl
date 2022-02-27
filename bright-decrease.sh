#!/bin/bash

# get screen name
screen_name=$(xrandr | grep " connected" | cut -f1 -d " ")

current_brightness=$(xrandr --verbose | awk '/Brightness/ {print $2}')
current_gamma=$(xrandr --verbose | awk '/Gamma/ {print $2}') 

# invert gamma
red=$(echo "$current_gamma" | cut -d':' -f1)
green=$(echo "$current_gamma" | cut -d':' -f2)
blue=$(echo "$current_gamma" | cut -d':' -f3)

red=$(echo "scale=3; 1/$red" | bc)
green=$(echo "scale=3; 1/$green" | bc)
blue=$(echo "scale=3; 1/$blue" | bc)

MIN_BRIGHTNESS=0.0

# decrease brightness
current_brightness=$(echo "$current_brightness-0.02" | bc)
if [ $(echo "$current_brightness >= $MIN_BRIGHTNESS" | bc) -eq 1 ]; then
    sed -i "s/default_brightness=.*/default_brightness=$current_brightness/" .zshrc
    xrandr --output $screen_name --brightness $current_brightness --gamma $red:$green:$blue
fi
