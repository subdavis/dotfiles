#!/bin/bash

sleep 0.2

feh  --bg-fill /home/brandon/.config/images/firefly.png
syndaemon -i 1 -KRd -t
synclient  VertScrollDelta=-27 # Reverse synaptics natural scroll
