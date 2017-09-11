#!/usr/bin/env bash

if [ -z $@ ]
then
cat ~/.mpvhist | sort

else
    GS=$@


    if [ -z $(grep "$GS" "$HOME/.mpvhist") ]; then
        echo $GS >> ~/.mpvhist
    fi

    if [ -n "$GS" ]; then 
        ID="$(echo $GS | sed -r 's/^.*[&?]v=(.{11})([&#].*)?$/\1/')"
        link="ytdl://$ID"
        mpv --quiet $link > /dev/null &
    fi
fi

