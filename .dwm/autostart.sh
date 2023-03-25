#!/bin/sh

# compositor
killall picom
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done
picom --vsync &

killall slstatus
while pgrep -u $UID -x slstatus >/dev/null; do sleep 1; done
slstatus

nm-applet &
~/.fehbg &
