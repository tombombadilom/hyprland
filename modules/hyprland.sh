#!/usr/bin/env bash

scripts="$(dirname "$0")"
package="anyrun"
log_dir="$scripts/log"
log_file="$log_dir/$package.log"

echo "Entering $package..." >> "$log_file"

function log() {
    echo "$1" >> "$log_file"
}

echo "Entering $package..." >> "$log_file"


# Check if hyprland is already installed
log "Checking if hyprland is installed"
if command -v hyprland &> /dev/null; then
    log "hyprland is already installed"
else
    log "hyprland not found, installing..."
    echo 'deb http://download.opensuse.org/repositories/home:/Sunderland93:/hyprland-debian/Debian_12/ /' | sudo tee /etc/apt/sources.list.d/home:Sunderland93:hyprland-debian.list
    curl -fsSL https://download.opensuse.org/repositories/home:Sunderland93:hyprland-debian/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_Sunderland93_hyprland-debian.gpg > /dev/null
    sudo apt update
    sudo apt install -y hyprland
    log "Installation complete"
fi

# Check if libpam0g-dev is already installed
log "Checking if libpam0g-dev is installed"
if dpkg-query -W -f='${Status}' libpam0g-dev 2>/dev/null | grep -q "install ok installed"; then
    log "libpam0g-dev is already installed"
else
    log "libpam0g-dev not found, installing..."
    sudo apt install -y libpam0g-dev
    log "Installation complete"
fi

# Uninstall development libraries
log "Uninstalling development libraries..."
sudo apt remove -y libgtk-3-dev
log "Uninstallation complete"