# dotfiles
A collection of my configuration and other dotfiles

# Things to install

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

## Applications

* Sublime Text to `/opt/sublime_text/sublime_text`
* Insync (deb) https://www.insynchq.com/downloads
* Spotify (snap)
* Firefox `sudo apt --purge --reinstall install firefox`
* Postman `/opt/Postman`
* VS Code

# Put stuff in its place

```bash
export DFPATH=~/github.com/subdavis/dotfiles
mkdir -p ~/.config/brandon

ln -s ~/.config/compton.conf $DFPATH/compton.conf
ln -s ~/.bashrc $DFPATH/bashrc
ln -s ~/.config/brandon/aliases_sh $DFPATH/aliases_sh
ln -s ~/.config/i3/config $DFPATH/config
ln -s ~/.config/i3status/config $DFPATH/i3status.conf
ln -s ~/.pureline.conf $DFPATH/pureline.conf
```