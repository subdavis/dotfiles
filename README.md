# dotfiles

A collection of my configuration and other dotfiles

## System

* Compton for compositing
* i3-gaps 
* hub for git
* yarn
* git-prompt (optional)
* https://github.com/chris-marsh/pureline
* twmnd
* dmenu
* neofetch
* mosh
* pureline
* docker CE
* devilspie

```bash
sudo apt install yarn
sudo apt install devilspie
sudo apt install twmnd
sudo apt install dmenu
sudo apt install mosh
sudo apt install neofetch
sudo apt install docker-ce
sudo apt install pass
sudo apt install compton
```

## Applications

* Sublime Text to `/opt/sublime_text/sublime_text`
* Insync (deb) https://www.insynchq.com/downloads
* Spotify (snap)
* Firefox `sudo apt --purge --reinstall install firefox`
* Postman `/opt/Postman`
* VS Code

## Put stuff in place

```bash
export DFPATH=~/github.com/subdavis/dotfiles
mkdir -p ~/.config/brandon
mkdir -p ~/.config/i3
mkdir -p ~/.config/i3status
mkdir -p ~/.devilspie
mkdir -p ~/.config/plasma-workspace/env

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

rm ~/.config/plasma-workspace/env/wm.sh
ln -s $DFPATH/wm.sh ~/.config/plasma-workspace/env/wm.sh

rm ~/.devilspie/vscode_transparent.ds
ln -s $DFPATH/vscode_transparent.ds ~/.devilspie/vscode_transparent.ds
```

## Setting up i3 on KDE

* Use the plasma profile from ssdm-greeter, don't select i3.  This is required to use KDE themes from within i3.
* In KDE theme settings, set `Workspace Theme -> Splash Screen -> None`
* Set the DPI `xrandr --dpi 144`

## Setting DPI elsewhere....

* Sublime text: `"dpi_scale": 2.0` in preferences
* Firefox: ????
* Misc: https://wiki.archlinux.org/index.php/HiDPI

# Bluetooth

https://mxlinux.org/forum/viewtopic.php?t=39597
https://bugs.freedesktop.org/show_bug.cgi?id=97064
https://wiki.archlinux.org/index.php/Bluetooth_headset#Configuration_via_CLI
