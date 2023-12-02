#!/usr/bin/env bash

packages=(
    sway
    swaybg
    swayidle
    swaylock
    xdg-desktop-portal-wlr
    xwayland
    adwaita-qt
    alsa-utils
    brightnessctl
    copyq
    fonts-dejavu
    fonts-firacode
    fonts-font-awesome
    fonts-ubuntu
    grimshot
    gthumb
    libglib2.0-bin
    libgtk-3-0
    libgtk-4-1
    libnotify-bin
    mako-notifier
    network-manager
    network-manager-gnome
    papirus-icon-theme
    pipewire-audio
    qt5-style-plugins
    qt5ct
    waybar
    wob
    wofi
    x11-utils
    sway-notification-center
    mako
    autotiling
    dex
)

mkdir -p ~/.config/sway



for package in "${packages[@]}"; do
    if ! dpkg-query -W -f='${Status}' "$package" 2>/dev/null | grep -q "ok installed"; then
        sudo apt install -y "$package"
    fi
done

cp /etc/sway/config ~/.config/sway/config

echo "Sway dependencies installed"

