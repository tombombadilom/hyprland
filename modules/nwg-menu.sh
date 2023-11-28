#!/usr/bin/env bash
sudo apt install -y golang-go libgtk-3-dev libgtk-layer-shell0
git clone https://github.com/NwgMenu/nwg-menu.git
cd nwg-menu || exit
make get
make build
sudo make install
cd ../
sudo rm -rf nwg-menu
sudo apt remove --autoremove y golang-go
