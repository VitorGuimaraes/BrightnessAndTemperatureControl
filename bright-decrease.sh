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
 

MIN_BRIGHTNESS=0.0

# increase bright
if [ $(echo "$current_brightness > $MIN_BRIGHTNESS" | bc) -eq 1 ]; then
    xrandr --output $screen_name --brightness $(echo "$current_brightness-0.1" | bc) --gamma $red:$green:$blue
fi

