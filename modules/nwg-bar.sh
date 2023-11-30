#!/usr/bin/env bash

# Variables
package="nwg-bar"
log_dir="logs"
log_file="$log_dir/installation.log"

# Create log directory
mkdir -p $log_dir

# Function to log messages
log() {
  local message=$1
  echo "$(date +"%Y-%m-%d %H:%M:%S"): $message" >> $log_file
}

# Function to display progress bar
progress_bar() {
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

# Check if package is already installed
log "Checking if $package is already installed..."
if command -v $package &> /dev/null; then
    log "$package is already installed."
else
    # Install required packages
    log "Installing required packages..."
    sudo apt install -y golang-go libgtk-3-dev libgtk-layer-shell0 &>> $log_file

    # Clone repository
    log "Cloning $package repository..."
    git clone https://github.com/nwg-piotr/nwg-bar.git &>> $log_file || {
        log "Failed to clone repository."
        exit 1
    }

    cd nwg-bar || {
        log "Failed to change directory."
        exit 1
    }

    # Get dependencies
    log "Running 'make get'..."
    make get &>> $log_file || {
        log "Failed to run 'make get'."
        exit 1
    }

    # Build
    log "Running 'make build'..."
    make build &>> $log_file || {
        log "Failed to run 'make build'."
        exit 1
    }

    # Install
    log "Installing $package..."
    sudo make install &>> $log_file || {
        log "Failed to install $package."
        exit 1
    }

    cd ../

    # Clean up
    log "Cleaning up..."
    rm -rf nwg-bar

    # Uninstall dev libraries
    log "Removing development libraries..."
    sudo apt -y remove --autoremove golang-go libgtk-3-dev libgtk-layer-shell0 &>> $log_file

    log "Refactoring complete."
fi

# Display installation log
cat $log_file