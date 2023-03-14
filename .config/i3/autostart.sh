#!/bin/sh

killall sxhkd
while pgrep -u $UID -x sxhkd >/dev/null; do sleep 1; done
sxhkd -m 1 -c ~/.config/i3/sxhkd/sxhkdrc &

# compositor
killall picom
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done
picom &

~/.config/i3/polybar/launch.sh &

~/.fehbg &
dunst &
mpd &
