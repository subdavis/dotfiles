#!/bin/bash
unalias gp

alias ls="exa";
alias ll='ls -alF --git'
alias la='ls -A'
alias l='ls -CF'
alias cat="bat";
alias d="docker";
alias dk="docker compose";
alias dc="docker compose";
# alias ldc="docker-compose";
alias gs="git status";
alias gc="git commit";
alias ga="git add -u";
alias gd="git diff";
alias gds="git diff --stat"
alias gl="git for-each-ref --sort=committerdate refs/heads/";
alias gf="git fetch";
alias gri="git rebase -i";
alias ghco="gh pr checkout";
alias main="git checkout main";

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
gp () {
  git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)
}
gpfwl () {
  git push --force-with-lease
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
  npx http-server ./
}
windows() {
  i3-msg -t get_tree | jq '.. | .window_properties? // empty'
}
vpnup() {
  pass VPN/${1} | nmcli c up ${1} --ask > /dev/null
}
vpndown() {
  vpnname=`nmcli c | grep vpn | cut -d ' ' -f1 | xargs nmcli c down`
}
wgup() {
  sudo systemctl enable wg-quick@wg0 --now
}
wgdown() {
  sudo systemctl disable wg-quick@wg0 --now
}
ffgif() {
  [ -z $1 ] && echo "usage: ffgif <file> <start> <duration> <fps> <width> <output>" && return;
  ffmpeg -i $1\
    -ss $2\
    -t $3\
    -vf "fps=${4},scale=${5}:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse"\
    -loop 0\
    $6
}
ffgif2() {
  [ -z $1 ] && echo "usage ffgif2 <input> <output>" && return;
  palette="/tmp/palette.png"
  filters="fps=10,scale=800:-1:flags=lanczos"
  ffmpeg -v warning -i $1 -vf "$filters,palettegen" -y $palette
  ffmpeg -v warning -i $1 -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y $2
}
syncpass() {
  pass git pull && pass git push
}
calibre-update() {
  sudo -v && wget --no-check-certificate -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin
}
