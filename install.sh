export DFPATH=~/github.com/subdavis/dotfiles

symlink() {
    pushd $1
    for f in $(find . ! -path . | sed "s|^\./||"); do
        if [ -d $f ]; then
            mkdir -p $2$f
        else
            rm $2$f
            ln -s $(pwd)/$f $2$f
        fi
    done;
    popd
}

symlink $(pwd)/home ~/
symlink $(pwd)/$HOSTNAME/home ~/

# Disable light-locker because it's trash
if [ -e /etc/xdg/autostart/light-locker.desktop ]; then
    sudo mv /etc/xdg/autostart/light-locker.desktop /etc/xdg/autostart/light-locker.desktop.bak
fi

# Disable network manager too, manage in userspace
if [ -e /etc/xdg/autostart/nm-applet.desktop ]; then
    sudo mv /etc/xdg/autostart/nm-applet.desktop /etc/xdg/autostart/nm-applet.desktop.bak
fi


# # https://wiki.archlinux.org/index.php/Xfce#Lock_the_screen
# xfconf-query -c xfce4-session -p /general/LockCommand -s "lxlock" --create -t string
