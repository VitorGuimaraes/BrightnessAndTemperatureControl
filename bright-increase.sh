# get screen name
screen_name=$(xrandr | grep " connected" | cut -f1 -d " ")

# get current brightness
current_brightness=$(xrandr --verbose | awk '/Brightness/ {print $2}')

# get current_gamma 
current_gamma=$(xrandr --verbose | awk '/Gamma/ {print $2}')  

# invert gamma
red=$(echo "$current_gamma" | cut -d':' -f1)
green=$(echo "$current_gamma" | cut -d':' -f2)
blue=$(echo "$current_gamma" | cut -d':' -f3)

red=$(echo "scale=2; 1/$red" | bc)
green=$(echo "scale=2; 1/$green" | bc)
blue=$(echo "scale=2; 1/$blue" | bc)

MAX_BRIGHTNESS=1.0

# increase brightness
current_brightness=$(echo "$current_brightness+0.1" | bc)
if [ $(echo "$current_brightness <= $MAX_BRIGHTNESS" | bc) -eq 1 ]; then
    sed -i "s/default_brightness=.*/default_brightness=$current_brightness/" .zshrc
    xrandr --output $screen_name --brightness $current_brightness --gamma $red:$green:$blue
fi
