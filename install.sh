export DFPATH=~/github.com/subdavis/dotfiles
mkdir -p ~/.config/brandon
mkdir -p ~/.config/i3
mkdir -p ~/.config/i3status
mkdir -p ~/.config/plasma-workspace/env
mkdir -p ~/.config/systemd/user

rm ~/.config/compton.conf
ln -s $DFPATH/compton.conf ~/.config/compton.conf

rm ~/.bashrc
ln -s $DFPATH/bashrc ~/.bashrc

rm ~/.config/brandon/aliases_sh
ln -s $DFPATH/aliases_sh ~/.config/brandon/aliases_sh

rm  ~/.config/i3/config
ln -s $DFPATH/config  ~/.config/i3/config

rm ~/.config/i3status/config
ln -s $DFPATH/i3status.conf ~/.config/i3status/config

rm ~/.pureline.conf
ln -s $DFPATH/pureline.conf ~/.pureline.conf

rm ~/.xinit
ln -s $DFPATH/xinit ~/.xinit

rm ~/.profile
ln -s $DFPATH/profile ~/.profile

rm ~/.Xresources
ln -s $DFPATH/Xresources ~/.Xresources

rm ~/.config/plasma-workspace/env/wm.sh
ln -s $DFPATH/wm.sh ~/.config/plasma-workspace/env/wm.sh

rm ~/.config/lxsession/Lubuntu/desktop.conf
ln -s $DFPATH/desktop.conf ~/.config/lxsession/Lubuntu/desktop.conf

rm ~/.config/lxsession/Lubuntu/autostart
ln -s $DFPATH/autostart ~/.config/lxsession/Lubuntu/autostart

# Systemd stuff
rm ~/.config/systemd/user/profile.env
ln -s $DFPATH/system/$HOSTNAME.profile.env ~/.config/systemd/user/profile.env

for f in $(ls system/); do
    rm ~/.config/systemd/user/$f
    ln -s $DFPATH/system/$f ~/.config/systemd/user/$f
done

# Disable light-locker because it's trash
if [ -e /etc/xdg/autostart/light-locker.desktop ]; then
    sudo mv /etc/xdg/autostart/light-locker.desktop /etc/xdg/autostart/light-locker.desktop.bak
fi

# https://wiki.archlinux.org/index.php/Xfce#Lock_the_screen
xfconf-query -c xfce4-session -p /general/LockCommand -s "lxlock" --create -t string

# Move host-specific files into place
rm ~/.config/login.sh
ln -s $DFPATH/$HOSTNAME/login.sh ~/.config/login.sh

# Enable user services
