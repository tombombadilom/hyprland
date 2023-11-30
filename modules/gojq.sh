#!/usr/bin/env bash

# Define variables
package="gojq"
log_dir="log"
log_file="$log_dir/$package.log"

# Show progress
echo "Starting installation..."

# Update packages
sudo apt update

# Check if Go is already installed
if ! command -v go &>/dev/null; then
  echo "Installing Go..."
  sudo apt install -y golang-go
fi

# Check if the package is already installed
if ! command -v $package &>/dev/null; then
  echo "Installing $package..."
  go install github.com/itchyny/gojq/cmd/gojq@latest |& tee gojq_install.log
fi

# Add gojq to the PATH
if ! grep -q "$(go env GOPATH)/bin" ~/.bashrc; then
  echo "Adding gojq to the PATH..."
  echo "export PATH=\$PATH:$(go env GOPATH)/bin" >> ~/.bashrc
  source ~/.bashrc
fi

# Show progress
echo "gojq installation completed."

# Cleanup after installation
sudo apt-get autoremove -y # Remove unnecessary packages
sudo apt-get clean         # Clean package cache

# Show progress
echo "Installation and cleanup completed."