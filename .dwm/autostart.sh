#!/bin/bash
killall sxhkd
while pgrep -u $UID -x sxhkd >/dev/null; do sleep 1; done
sxhkd -m -1 -c ~/.config/suckless/dwm/sxhkd/sxhkdrc &

# compositor
killall picom
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done
picom &

# ~/.config/suckless/dwm/polybar/launch.sh &

dunst &
mpd &
nm-applet &
~/.fehbg &
