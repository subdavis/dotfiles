#!/bin/bash

sleep 0.2

# wmctrl -c Plasma
/home/brandon/github.com/subdavis/dotfiles/xrandr.sh

sleep 0.2 # sleep before feh

feh  --bg-fill /home/brandon/cloud/pictures/Backgrounds/hexagony.jpg  --bg-fill /home/brandon/cloud/pictures/Backgrounds/dawny.jpg
syndaemon -i 1 -KRd -t
synclient  VertScrollDelta=-27
