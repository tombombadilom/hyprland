#!/usr/bin/env bash
sudo apt install -y sudo apt install dbus libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev libcairo2-dev libnotify-dev wayland-client-protocols xdg-utils
git clone https://github.com/dunst-project/dunst.git
cd dunst || exit
make get
make build
sudo make install
cd ../
rm -rf dunst
sudo apt autoremove
