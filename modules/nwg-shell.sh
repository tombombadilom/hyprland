#!/usr/bin/env bash
sudo apt install -y python3-setuptools
git clone https://github.com/nwg-piotr/nwg-shell.git
cd nwg-shell || exit
chmod +x setup.py
sudo python3 setup.py install
cd ../
sudo rm -rf nwg-shell
sudo apt remove -y python3-setuptools
sudo apt auto-remove -y
