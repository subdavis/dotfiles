#!/bin/sh

# xrandr --newmode "3840x2160_50.00"  587.00  3840 4144 4560 5280  2160 2163 2168 2225 -hsync +vsync
# xrandr --addmode DisplayPort-2 "3840x2160_50.00"
# xrandr --addmode DisplayPort-1 "3840x2160_50.00"
# xrandr --output DisplayPort-2 --mode "3840x2160_50.00"
# xrandr --output DisplayPort-1 --mode "3840x2160_50.00" --right-of DisplayPort-2
xrandr --output DisplayPort-1 --rotate right
xrandr --output DisplayPort-1 --right-of DisplayPort-2
xrandr --output DisplayPort-2 --primary
