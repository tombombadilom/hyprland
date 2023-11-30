#!/usr/bin/env bash
# shellcheck disable=SC2034
scripts="$(dirname "$0")"
package="nwg-menu"
# shellcheck disable=SC2154
log_dir="$script/log"
log_file="$log_dir/$package.log"

echo "Entering $package..." | tee -a "$log_file"

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
    echo "$(date): $1" | tee -a "$log_file"
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

# Run the command to download dependencies
# Add the code for the progress bar here
# Update the progress bar as the dependencies are being downloaded

# Example progress bar implementation
total_dependencies=10
current_progress=0
while [ $current_progress -lt $total_dependencies ]; do
    current_progress=$((current_progress + 1))
    percentage=$((current_progress * 10))
    progress="["
    for ((i=0; i<current_progress; i++)); do
        progress+="="
    done
    progress+=">"
    for ((i=current_progress; i<total_dependencies; i++)); do
        progress+=" "
    done
    progress+="]"
    log "Progress: $progress $percentage%"
    sleep 1
done

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