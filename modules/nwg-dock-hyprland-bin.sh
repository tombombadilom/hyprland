#!/usr/bin/env bash
sudo apt install -y golang-go libgtk-3-dev libgtk-layer-shell0
git clone https://github.com/nwg-piotr/nwg-dock.git
cd nwg-dock
make get
make build
sudo make install
cd ../
rm -rf nwg-dock
sudo apt -y remove --autoremove golang-go
