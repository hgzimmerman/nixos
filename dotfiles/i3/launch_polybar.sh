#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done



xrandr --query | grep "\b connected" | awk '{print $1;}' | while read -r line
do 
    if [ "$line" = 'eDP-1' ]; then
        polybar --config=/etc/nixos/dotfiles/i3/config eDP-1 &
        echo "launched eDP-1"
    elif [ "$line" = 'DP-1' ]; then
        polybar --config=/etc/nixos/dotfiles/i3/config DP-1 &
        echo "launched DP-1"
    elif [ "$line" = 'HDMI-0' ]; then
        polybar --config=/etc/nixos/dotfiles/i3/config HDMI-0 &
        echo "launched HDMI-1"
    elif [ "$line" = 'DP-4' ]; then
        polybar --config=/etc/nixos/dotfiles/i3/config DP-4 &
        echo "launched DP-4"
    elif [ "$line" = 'DVI-D-0' ]; then
        polybar --config=/etc/nixos/dotfiles/i3/config DVI-D-0 &
        echo "launched DVI-D-0"
    fi

done



