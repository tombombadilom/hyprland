#!/usr/bin/env bash
sudo apt install -y libpam0g-dev libcairo2-dev libxcb1-dev libxcb-dpms0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xinerama0-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-keysyms1-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf imagemagick libev-dev
git clone https://github.com/Raymo111/i3lock-color.git
cd i3lock-color
autoreconf -i && ./configure && make
sudo make install
cd ../
rm -rf i3lock-color
# autoinstall for system
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | sudo bash -s system
# autoinstall for user
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | bash -s user
# remove dev packages
sudo apt remove -y libpam0g-dev libcairo2-dev libxcb1-dev libxcb-dpms0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xinerama0-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-keysyms1-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libev-dev
sudo apt auto-remove -y