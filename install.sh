#!/bin/bash

export DFPATH=~/github.com/subdavis/dotfiles

symlink() {
    pushd $1 > /dev/null
    for f in $(find . ! -path . | sed "s|^\./||"); do
        if [ -d $f ]; then
            mkdir -p $2$f
        else
            rm $2$f
            ln -s $(pwd)/$f $2$f
        fi
    done;
    popd > /dev/null
}

if [ "$USER" == "root" ]; then

    echo "RUN AS ROOT"

    [ -d root/ ] && symlink $(pwd)/root /
    [ -d $HOSTNAME/root ] && symlink $(pwd)/$HOSTNAME/root /

    # Disable light-locker
    [ -e /etc/xdg/autostart/light-locker.desktop ] && mv /etc/xdg/autostart/light-locker.desktop /etc/xdg/autostart/light-locker.desktop.bak
    # Disable network manage applet, manage in userspace
    [ -e /etc/xdg/autostart/nm-applet.desktop ] && mv /etc/xdg/autostart/nm-applet.desktop /etc/xdg/autostart/nm-applet.desktop.bak

else

    echo "RUN AS nonroot $USER"

    [ -d home/ ] && symlink $(pwd)/home ~/
    [ -d $HOSTNAME/home ] && symlink $(pwd)/$HOSTNAME/home ~/

fi

# Check for root/nonroot within this script as well.
[ -f $HOSTNAME/install.sh ] && ./$HOSTNAME/install.sh
