#!/bin/bash

sleep 0.1

feh  --bg-fill /home/brandon/cloud/pictures/Backgrounds/Firefly.png

syndaemon -i 1 -KRd -t
/usr/bin/nm-applet
/usr/bin/insync start