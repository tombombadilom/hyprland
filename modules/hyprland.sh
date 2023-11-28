#!/usr/bin/env bash
echo "install hyprland from suse binaries for Debian 13"
echo 'deb http://download.opensuse.org/repositories/home:/Sunderland93:/hyprland-debian/Debian_12/ /' | sudo tee /etc/apt/sources.list.d/home:Sunderland93:hyprland-debian.list
curl -fsSL https://download.opensuse.org/repositories/home:Sunderland93:hyprland-debian/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_Sunderland93_hyprland-debian.gpg > /dev/null
sudo apt update
sudo apt install -y hyprland
echo "Installation complete"