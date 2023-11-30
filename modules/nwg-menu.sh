#!/usr/bin/env bash

package="golang-go"
log_dir="/path/to/log/dir"
log_file="/path/to/log/file.log"
progress="[                    ]"

# Check if the package is already installed
if ! dpkg -s "$package" >/dev/null 2>&1; then
    echo "Installing $package..."
    sudo apt install -y "$package"
else
    echo "$package is already installed."
fi

# Clone the repository
git clone https://github.com/NwgMenu/nwg-menu.git
cd nwg-menu || exit

# Add logs
function log() {
    echo "$1"
    echo "$(date): $1" >> "$log_file"
}

log "Cloning repository..."

# Make get
log "Running make get..."
make get

# Make build
log "Running make build..."
make build

# Add progress bar for dependencies download
log "Downloading dependencies..."
log "Progress: $progress 0%"

# Run the command to download dependencies
# Add the code for the progress bar here
# Update the progress bar as the dependencies are being downloaded

# Make install
log "Running make install..."
sudo make install

cd ../

# Remove the cloned repository
sudo rm -rf nwg-menu

# Remove the package if it was installed
if dpkg -s "$package" >/dev/null 2>&1; then
    log "Removing $package..."
    sudo apt remove --autoremove y "$package"
else
    log "$package was not installed."
fi