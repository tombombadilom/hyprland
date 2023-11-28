#!/usr/bin/env bash
sudo apt install -y golang-go libgtk-3-dev libgtk-layer-shell0
git clone https://github.com/nwg-piotr/nwg-displays.git
cd nwg-displays || exit
make get
make build
sudo make install
cd ../
rm -rf nwg-displays
sudo apt -y remove --autoremove golang-go
