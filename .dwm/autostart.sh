#!/bin/sh

~/.fehbg &

killall slstatus
while pgrep -u $UID -x slstatus >/dev/null; do sleep 1; done
slstatus &

killall nm-applet
while pgrep -u $UID -x nm-applet >/dev/null; do sleep 1; done
nm-applet &

killall sxhkd
while pgrep -u $UID -x sxhkd >/dev/null; do sleep 1; done
sxhkd -m -1 -c ~/.config/suckless/dwm/sxhkd/sxhkdrc

exec mpd &
