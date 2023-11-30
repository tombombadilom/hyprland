#!/usr/bin/env bash

# Define variables
package="gojq"
log_dir="log"
log_file="$log_dir/$package.log"

echo "Entering $package..." | tee -a "$log_file"

# Function to log messages
log() {
  local message=$1
  echo "$(date +"%Y-%m-%d %H:%M:%S"): $message" | tee -a "$log_file"
}

# Function to check if package is already installed
is_installed() {
  local pkg=$1
  if command -v "$pkg" &> /dev/null; then
    return 0
  else
    return 1
  fi
}

# Show progress
log "Starting installation..."

# Update packages
sudo apt update

# Check if Go is already installed
if ! is_installed go; then
  log "Installing Go..."
  sudo apt install -y golang-go
fi

# Check if the package is already installed
if ! is_installed "$package"; then
  log "Installing $package..."
  go install github.com/itchyny/gojq/cmd/gojq@latest |& tee gojq_install.log
fi

# Add gojq to the PATH
if ! grep -q "$(go env GOPATH)/bin" ~/.bashrc; then
  log "Adding gojq to the PATH..."
  echo "export PATH=\$PATH:$(go env GOPATH)/bin" | tee -a ~/.bashrc
  source ~/.bashrc
fi

# Show progress
log "gojq installation completed."

# Cleanup after installation
sudo apt-get autoremove -y # Remove unnecessary packages
sudo apt-get clean         # Clean package cache

# Show progress
log "Installation and cleanup completed."