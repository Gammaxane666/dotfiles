#!/usr/bin/env bash

polybar-msg cmd quit
                      
echo "---" | tee -a /tmp/polybar1.log 
polybar -c ~/.xmonad/polybar/config.ini xmonad 2>&1 | tee -a /tmp/polybar1.log & disown
