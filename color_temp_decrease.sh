#!/bin/bash

# Decrease
# 2000 -> 6500
declare -A temperatures
temperatures[1.000:.555:.083]=1.00000000:0.64373109:0.28819679  
temperatures[1.000:.625:.285]=1.00000000:0.71976951:0.42860152  
temperatures[1.000:.714:.434]=1.00000000:0.77987699:0.54642268  
temperatures[1.000:.769:.555]=1.00000000:0.82854786:0.64816570  
temperatures[1.000:.833:.666]=1.00000000:0.86860704:0.73688797  
temperatures[1.000:.833:.714]=1.00000000:0.90198230:0.81465502  
temperatures[1.000:.909:.833]=1.00000000:0.93853986:0.88130458  
temperatures[1.000:.909:.909]=1.00000000:0.97107439:0.94305985  
temperatures[1.000:1.000:.909]=1.00000000:1.00000000:1.00000000 
temperatures[1.000:1.000:1.000]=1.00000000:1.00000000:1.00000000 

screen_name=$(xrandr | grep " connected" | cut -f1 -d " ")

current_brightness=$(xrandr --verbose | awk '/Brightness/ {print $2}')  
current_gamma=$(xrandr --verbose | awk '/Gamma/ {print $2}') 

red=$(echo "$current_gamma" | cut -d':' -f1)
green=$(echo "$current_gamma" | cut -d':' -f2)
blue=$(echo "$current_gamma" | cut -d':' -f3)

red=$(echo "scale=3; 1/$red" | bc)
green=$(echo "scale=3; 1/$green" | bc)
blue=$(echo "scale=3; 1/$blue" | bc)

gamma=$(echo ${temperatures[$red:$green:$blue]})
echo $red:$green:$blue
echo $gamma

xrandr --output $screen_name --brightness $(echo $current_brightness) --gamma $(echo $gamma)
sed -i "s/default_gamma=.*/default_gamma=$gamma/" .zshrc
