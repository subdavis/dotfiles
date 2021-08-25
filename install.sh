#!/bin/bash

export DFPATH="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"

symlink() {
    echo "SYNC $1 $2"
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

    [ -d ${DFPATH}/root/ ] && symlink ${DFPATH}/root /
    [ -d ${DFPATH}/$HOSTNAME/root ] && symlink ${DFPATH}/$HOSTNAME/root /

    # Disable light-locker
    [ -e /etc/xdg/autostart/light-locker.desktop ] && mv /etc/xdg/autostart/light-locker.desktop /etc/xdg/autostart/light-locker.desktop.bak
    # Disable network manage applet, manage in userspace
    [ -e /etc/xdg/autostart/nm-applet.desktop ] && mv /etc/xdg/autostart/nm-applet.desktop /etc/xdg/autostart/nm-applet.desktop.bak

else

    echo "RUN AS nonroot $USER"

    [ -d ${DFPATH}/home/ ] && symlink ${DFPATH}/home ~/
    [ -d ${DFPATH}/$HOSTNAME/home ] && symlink ${DFPATH}/$HOSTNAME/home ~/

    xdg-user-dirs-update
fi

# Check for root/nonroot within this script as well.
[ -f $HOSTNAME/install.sh ] && ./$HOSTNAME/install.sh
