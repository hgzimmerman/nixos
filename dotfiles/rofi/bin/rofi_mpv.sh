#!/usr/bin/env bash

if [ -z $@ ]
then
cat ~/.mpvhist | sort

else
    GS=$@


    if [ -z $(grep -q "$GS" "$HOME/.mpvhist") ]; then
        echo $GS >> ~/.mpvhist
    fi

    if [ -n "$GS" ]; then 
        mpv --quiet $GS > /dev/null &
    fi
fi

