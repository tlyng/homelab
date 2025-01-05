#!/usr/bin/env bash

CURRENT=$(hyprctl getoption -j input:kb_layout | jq -r .str)

if [[ $CURRENT == "us" ]]
then
    hyprctl keyword input:kb_layout no;
else
    hyprctl keyword input:kb_layout us;
fi

