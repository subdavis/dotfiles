#!/bin/bash

if [ "$USER" == "root" ]; then
  [ -e /usr/bin/lxlock ] && mv /usr/bin/lxlock /usr/bin/lxlock.old
fi
