#!/usr/bin/env bash

polybar-msg cmd quit
                      
echo "---" | tee -a /tmp/polybar1.log 
polybar -c ~/.config/qtile/polybar/config.ini qtile 2>&1 | tee -a /tmp/polybar1.log & disown
