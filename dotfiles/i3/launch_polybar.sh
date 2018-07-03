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
    elif [ "$line" = 'DP-0' ]; then
        polybar --config=/etc/nixos/dotfiles/i3/config DP-0 &
        echo "launched DP-0"
    elif [ "$line" = 'HDMI-0' ]; then
        polybar --config=/etc/nixos/dotfiles/i3/config HDMI-0 &
        echo "launched HDMI-0"
    elif [ "$line" = 'DP-4' ]; then
        polybar --config=/etc/nixos/dotfiles/i3/config DP-4 &
        echo "launched DP-4"
    elif [ "$line" = 'DVI-D-0' ]; then
        polybar --config=/etc/nixos/dotfiles/i3/config DVI-D-0 &
        echo "launched DVI-D-0"
    elif [ "$line" = 'DVI-D-1' ]; then
        polybar --config=/etc/nixos/dotfiles/i3/config DVI-D-1 &
        echo "launched DVI-D-1"
    fi

done



