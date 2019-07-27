![screenshot](screenshots/dirty.png)

# dotfiles

A collection of my configuration and other dotfiles.

* KDE Ubuntu + 3-gaps
* LXDE Ubuntu + i3-gaps

## Things to install

```bash
sudo apt install i3-wm i3 i3lock
sudo apt install compton
sudo apt install curl
sudo apt install virtualenv
sudo apt install yarn npm
sudo npm install -g n
sudo n lts
sudo apt install dmenu j4-dmenu-desktop
sudo apt install neofetch
sudo apt install mosh
sudo apt install chromium-browser
```

## Other Applications

* [Hub for Git](https://github.com/github/hub/releases)
* [Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
* Sublime Text to `/opt/sublime_text/sublime_text`
* Insync (deb) https://www.insynchq.com/downloads
* Spotify (snap)
* Firefox `sudo apt --purge --reinstall install firefox`
* Postman `/opt/Postman`
* VS Code

# Put stuff in its place

```bash
# Run install to place all the dotfiles in the right places
./install.sh
```

## Setting up i3 on KDE

* Use the plasma profile from ssdm-greeter, don't select i3.  This is required to use KDE themes from within i3.
* In KDE theme settings, set `Workspace Theme -> Splash Screen -> None`
* Set the DPI `xrandr --dpi 144`

## Setting DPI elsewhere....

* Sublime text: `"dpi_scale": 2.0` in preferences
* Firefox: ????
* Misc: https://wiki.archlinux.org/index.php/HiDPI

## Various other setup

```bash
sudo update-alternatives --config x-terminal-emulator
```

* Touchpad Synaptics https://askubuntu.com/questions/773595/how-can-i-disable-touchpad-while-typing-on-ubuntu-16-04-syndaemon-isnt-working
