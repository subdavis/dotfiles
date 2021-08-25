#!/bin/bash

sleep 0.2

# wmctrl -c Plasma
/home/brandon/.config/xrandr.sh

sleep 0.2 # sleep before feh

feh  --bg-fill /home/brandon/.config/images/penguins.jpg --bg-fill /home/brandon/.config/images/penguins-upright.jpg
