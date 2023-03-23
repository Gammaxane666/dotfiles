#!/bin/sh
# compositor
killall picom
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done
picom &

~/.config/suckless/dwm/polybar/launch.sh &

exec nm-applet &
~/.fehbg &
