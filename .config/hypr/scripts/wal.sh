#!/usr/bin/env bash

if [ -x "$(command -v feh)" ]; then
  feh --randomize --bg-fill $HOME/Images/wallpaper/*
fi
