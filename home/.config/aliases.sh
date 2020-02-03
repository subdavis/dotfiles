#!/bin/bash

export VAULT_ADDR=https://vault.kitware.com

alias ls="exa-linux-x86_64";
alias cat="bat";

ssh-start() {
  eval `ssh-agent -s`
}
ssh-addkeys() {
  for f in ~/.ssh/*_rsa
  do
    ssh-add "$f"
  done
}
pysrc() {
  if [ -e venv ]; then
    source venv/bin/activate
  elif [ -e bin/ ]; then
    source bin/activate
  else
    python3 -m venv venv/
  fi
}
pywinsrc() {
  source Scripts/activate
}
nmcycle() {
  # Restart the network manager service
  sudo service network-manager restart
}
above() {
  xrandr --output DP-1 --scale 2x2 --mode 1920x1080 --fb 3840x4200 --pos 0x0
  xrandr --output eDP-1 --scale 1x1 --pos 320x2400
}
beside() {
  sudo xrandr --output VGA1 --right-of eDP1 --mode 1920x1080
}
cueflac(){
  # JUST A TEMPLATE
  mkdir tracks && shnsplit -f *.cue -t %n-%t -d tracks -o flac *.flac
}
flactomp3(){
  for f in *.flac;
    do
      base=$(basename "$f" .flac);
      ffmpeg -i "$f" -ab 196k -ac 2 -ar 48000 "$base.mp3";
  done;
}
battery(){
  upower -i /org/freedesktop/UPower/devices/battery_BAT0
}
extract () {
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2) tar xvjf "$1";;
      *.tar.gz) tar xvzf "$1";;
      *.bz2) bunzip2 "$1";;
      *.rar) unrar x "$1";;
      *.gz) gunzip "$1";;
      *.tar) tar xvf "$1";;
      *.tbz2) tar xvjf "$1";;
      *.tgz) tar xvzf "$1";;
      *.zip) unzip "$1";;
      *.Z) uncompress "$1";;
      *.7z) 7za x "$1";;
      *.rar) unrar "$1";;
      *) echo "'$1' cannot be extracted via >extract<" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
gpush () {
  for o in $(git remote show); do
    echo "Pushing to $o";
    git push $o;
  done; 
}
gpushsu () {
  git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)
}
gmirror () {
  mkdir -p ~/github.com/mirrors
  [ -z $1 ] && echo "usage: gmirror new|update" && return;
  case $1 in
    new) 
      [ -z $2 ] && echo "usage: gmirror new username oldreponame newreponame" && return;
      git clone --mirror git@github.com:$2/$3.git ~/github.com/mirrors/$4.git
      pushd . 
      cd ~/github.com/mirrors/$4.git
      git remote set-url --push origin git@gitlab.com:$2/$4.git
      popd
      gmirror update
    ;;
    update)
      pushd .
      cd ~/github.com/mirrors
      for d in $(ls ~/github.com/mirrors)
      do
        echo "Updating $d"
        cd $d
        git fetch -p origin
        git push --mirror
        cd ..
      done
      popd
    ;;
  esac
}
findbigfiles () {
  find / -xdev -type f -size +100M 2>/dev/null
}
wificonnect () {
  nmcli device wifi con "$1" password "$2"
}
grepass () {
  last="${@: -1}"
  count=$#
  if [ ! -z $1 ] && [[ $last != *"/"* ]] && [[ $last != *"--"* ]]; then
    pass ${@:1:$((count-1))} | grep $last | sed "s/$last:\s//"
  else
    pass $@;
  fi
}
lexec() {
  1
  while IFS= read -r line; do
    if [[ $line == $1* ]]; then
      $(sed "s/$1:\s//" <<< $line)
      echo $AWS_ACCESS_KEY_ID
      AWS_ACCESS_KEY_ID="FOOOO"
    fi
  done
}
bright () {
  XRANDR=`xrandr --verbose`
  ACTIVE_DISPLAY=`xrandr | grep " connected " | awk '{ print$1 }'`
  # BRIGHTNESS=`xrandr --verbose | grep -m 1 -i brightness | cut -f2 -d ' '`
  BRIGHTNESS=`bc -l <<< "$1/10"`
  xrandr --output $ACTIVE_DISPLAY --brightness $BRIGHTNESS
}
shs() {
  python -m SimpleHTTPServer 7000
}
windows() {
  i3-msg -t get_tree | jq '.. | .window_properties? // empty'
}
# alias pass=grepass
complete -F _pass grepass
