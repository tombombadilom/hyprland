#!/usr/bin/env bash
sudo apt install -y golang-go libgtk-3-dev libgtk-layer-shell0
git clone https://github.com/nwg-piotr/nwg-bar.git
cd nwg-bar || exit
make get
make build
sudo make install
cd ../
rm -rf nwg-bar
sudo apt -y remove --autoremove golang-go
