#!/usr/bin/env bash

if [ -d "/usr/lib/xdg-desktop-portal-hyprland" ]; then
    echo "xdg-desktop-portal-hyprland est déjà installé dans /usr/lib/xdg-desktop-portal-hyprland"
else
    git clone --recursive https://github.com/hyprwm/xdg-desktop-portal-hyprland
    cd xdg-desktop-portal-hyprland/
    make all
    sudo make install
fi
echo "xdg-desktop-portal-hyprland est maintenant installé dans /usr/lib/xdg-desktop-portal-hyprland"
