#!/bin/bash

sleep 0.1

wmctrl -c Plasma

/home/brandon/github.com/subdavis/dotfiles/xrandr.sh

sleep 0.1

feh  --bg-fill /home/brandon/cloud/pictures/Backgrounds/hexagony.jpg  --bg-fill /home/brandon/cloud/pictures/Backgrounds/dawny.jpg

syndaemon -i 1 -KRd -t
/usr/bin/nm-applet