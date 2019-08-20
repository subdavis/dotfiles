#!/bin/bash

sleep 0.2

# wmctrl -c Plasma
/home/brandon/.config/xrandr.sh

sleep 0.2 # sleep before feh

feh  --bg-fill /home/brandon/github.com/subdavis/dotfiles/images/firefly-upright.png --bg-fill /home/brandon/github.com/subdavis/dotfiles/images/firefly.png

