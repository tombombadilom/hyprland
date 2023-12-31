#!/usr/bin/env bash

# Variables
# shellcheck disable=SC2034
scripts="$(dirname "$0")"
package="nwg-displays"
log_dir="$scripts/log"
log_file="$log_dir/$package.log"
duration=0.1
prefix="Progress: "
suffix=""
chars=("▏" "▎" "▍" "▌" "▋" "▊" "▉" "█")
num_chars=${#chars[@]}
total_width=50

echo "Entering $package..." | tee  "$log_file"

# Add logging
log() {
  echo "$(date +"%Y-%m-%d %H:%M:%S"): $1"
}

# Add progress bar
progress_bar() {
  local percent=$((i * 100 / total_width))
  local progress=$((i * total_width / 100))
  printf "\r\e[K$prefix${chars[progress % num_chars]}$suffix [$percent%%]"
}

log "Cloning $package repository..."
git clone https://github.com/nwg-piotr/$package.git || { log "Failed to clone repository."; exit 1; }

cd $package || { log "Failed to change directory."; exit 1; }
log "Installing $package..."
python3 setup.py install --optimize=1

log "Installing dependencies..."
cp nwg-displays.svg /usr/share/pixmaps/

log "Installing desktop file..."
cp nwg-displays.desktop /usr/share/applications/

cd ../

log "Cleaning up..."
rm -rf $package

log "Removing golang-go..."
sudo apt -y remove --autoremove golang-go

log "Removing libgtk-3-dev..."
sudo apt -y remove --autoremove libgtk-3-dev

log "Removing libgtk-layer-shell0..."
sudo apt -y remove --autoremove libgtk-layer-shell0

log "Refactoring complete."