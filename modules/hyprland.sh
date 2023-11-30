#!/usr/bin/env bash

package="hyprland"
log_dir="log"
log_file="$log_dir/$package.log"

function log() {
    echo "$1" >> "$log_file"
}

log "Check if hyprland is installed"
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

log "Add progress and log"
# Add your code for adding progress and log here

# Progress bar (added)
log "Adding progress bar"
pv -n < /dev/zero | sudo dd of=/dev/null bs=1M count=100 2>&1 | \
    while read -r progress; do
        echo "$progress"
    done

# Check if libpam0g-dev is installed
if dpkg-query -W -f='${Status}' libpam0g-dev 2>/dev/null | grep -q "install ok installed"; then
    log "libpam0g-dev is already installed"
else
    log "Installing libpam0g-dev..."
    sudo apt install -y libpam0g-dev
    log "Installation complete"
fi

log "Uninstalling development libraries..."
sudo apt remove -y libgtk-3-dev
log "Uninstallation complete"

log "Installation complete"