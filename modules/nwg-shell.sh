#!/usr/bin/env bash

package="nwg-shell"
log_dir="log"
log_file="$log_dir/$package.log"

sudo apt install -y python3-setuptools

# Function to print log messages
function log_message() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") $1" >> "$log_file"
}

# Function to print progress bar
function print_progress() {
    local progress=$1
    local total=$2
    local percentage=$((progress * 100 / total))
    local bar_length=20
    local completed_length=$((bar_length * percentage / 100))
    local remaining_length=$((bar_length - completed_length))

    printf "["
    printf "%${completed_length}s" | tr ' ' '#'
    printf "%${remaining_length}s" | tr ' ' ' '
    printf "] %d%%\r" "$percentage"
}

log_message "Installing nwg-shell..."
git clone https://github.com/nwg-piotr/nwg-shell.git
cd nwg-shell || exit
chmod +x setup.py

log_message "Running setup.py..."
sudo python3 setup.py install

# Uninstallation of development libraries
log_message "Uninstalling development libraries..."
sudo apt remove -y python3-setuptools
sudo apt auto-remove -y

cd ../
sudo rm -rf nwg-shell

log_message "Installation complete."