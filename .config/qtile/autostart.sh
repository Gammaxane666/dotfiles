#!/bin/sh

killall sxhkd
while pgrep -u $UID -x sxhkd >/dev/null; do sleep 1; done
sxhkd -m -1 -c ~/.config/qtile/sxhkd/sxhkdrc &

# compositor
killall picom
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done
picom &

~/.config/qtile/polybar/launch.sh &

mpd &
nm-applet &
~/.fehbg &
