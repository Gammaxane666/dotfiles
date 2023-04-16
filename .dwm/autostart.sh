#!/bin/sh

~/.fehbg &

picom --vsync &

killall nm-applet
while pgrep -u $UID -x nm-applet >/dev/null; do sleep 1; done
nm-applet &

killall slstatus
while pgrep -u $UID -x slstatus >/dev/null; do sleep 1; done
slstatus &
