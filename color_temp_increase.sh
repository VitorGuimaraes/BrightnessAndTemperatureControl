screen_name=$(xrandr | grep " connected" | cut -f1 -d " ")

# get current brightness
current_brightness=$(xrandr --verbose | awk '/Brightness/ {print $2}')  

# get current_gamma 
current_gamma=$(xrandr --verbose | awk '/Gamma/ {print $2}') 

current_red=$(echo "$current_gamma" | cut -d':' -f1)
current_green=$(echo "$current_gamma" | cut -d':' -f2)
current_blue=$(echo "$current_gamma" | cut -d':' -f3)
gamma=$(echo "$current_red"+"$current_green"+"$current_blue" | bc)

if [ $(echo "$gamma >= 3" | bc) -eq 1 ]; then
    target_gamma='0.90:0.90:1.0'
elif [ $(echo "$gamma >= 2.8 && $gamma < 3" | bc) -eq 1 ]; then
    target_gamma='0.80:0.90:1.0'
elif [ $(echo "$gamma >= 2.7 && $gamma < 2.8" | bc) -eq 1 ]; then
    target_gamma='0.80:0.80:1.0'
elif [ $(echo "$gamma >= 2.6 && $gamma < 2.7" | bc) -eq 1 ]; then
    target_gamma='0.70:0.80:1.0'
fi


red=$(echo "$target_gamma" | cut -d':' -f1)
green=$(echo "$target_gamma" | cut -d':' -f2)
blue=$(echo "$target_gamma" | cut -d':' -f3)

red=$(echo "scale=2; 1/$red" | bc)
green=$(echo "scale=2; 1/$green" | bc)
blue=$(echo "scale=2; 1/$blue" | bc)

xrandr --output $screen_name --brightness $(echo $current_brightness) --gamma $red:$green:$blue 
