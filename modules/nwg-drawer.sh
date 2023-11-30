#!/usr/bin/env bash

package="nwg-drawer"
log_dir="log"
log_file="$log_dir/$package.log"
progress=""

function log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S"): $1" >> "$log_file"
}

function show_progress() {
    local duration=$1
    local prefix=$2
    local suffix=$3
    local chars=("▏" "▎" "▍" "▌" "▋" "▊" "▉" "█")
    local num_chars=${#chars[@]}
    local total_width=50

    for ((i=0; i<=$total_width; i++)); do
        sleep $duration
        local percent=$((i * 100 / total_width))
        local progress=$((i * total_width / 100))
        printf "\r\e[K$prefix${chars[progress % num_chars]}$suffix [$percent%%]"
    done
    echo
}

log "Checking if $package is already installed..."
if command -v $package &> /dev/null; then
    log "$package is already installed."
else
    log "$package not found, installing..."
    show_progress 0.1 "Progress: " "[                    ]" &
    progress=$!
    sudo apt install -y golang-go libgtk-3-dev libgtk-layer-shell0 && kill $progress

    log "Cloning $package repository..."
    git clone https://github.com/nwg-piotr/nwg-drawer.git
    cd nwg-drawer || { log "Failed to change directory."; exit 1; }

    log "Running 'make get'..."
    make get || { log "Failed to run 'make get'."; exit 1; }

    log "Running 'make build'..."
    make build || { log "Failed to run 'make build'."; exit 1; }

    log "Installing $package..."
    sudo make install || { log "Failed to install $package."; exit 1; }

    cd ../

    log "Cleaning up..."
    rm -rf nwg-drawer

    log "$package installation complete."
fi

log "Removing golang-go..."
show_progress 0.1 "Progress: " "[                    ]" &
progress=$!
sudo apt -y remove --autoremove golang-go && kill $progress

log "Installation complete."