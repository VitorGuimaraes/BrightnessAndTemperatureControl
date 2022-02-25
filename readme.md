1) copy the files to path that you prefer
2) give all permissions with sudo chmod +x script.sh
3) create a shorcut for each script: Search for Keyboard → Application Shortcuts
4) add in your .bashrc:
```
export default_brightness=.50
export default_gamma=1.0:1.0:1.0
screen_name=$(xrandr | grep " connected" | cut -f1 -d " ")
xrandr --output $screen_name --brightness $default_brightness --gamma $default_gamma
```
