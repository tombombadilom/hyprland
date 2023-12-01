#!/usr/bin/env bash
sudo apt install sway swaybg swayidle swaylock xdg-desktop-portal-wlr xwayland
sudo apt install adwaita-qt alsa-utils brightnessctl copyq fonts-dejavu fonts-firacode fonts-font-awesome fonts-ubuntu grimshot gthumb libglib2.0-bin libgtk-3-0 libgtk-4-1 libnotify-bin mako-notifier network-manager network-manager-gnome papirus-icon-theme pipewire-audio qt5-style-plugins qt5ct waybar wob wofi x11-utils

mkdir -p ~/.config/sway

cp /etc/sway/config ~/.config/sway/config


