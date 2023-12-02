#!/usr/bin/env bash

export LC_ALL=C.UTF-8
export LANG=C.UTF-8

# Get the script directory
script_dir="$(dirname "$0")"

# Create log directory
mkdir -p "$script_dir/log"

# Set configuration source and target directories
config_dir="$HOME/.config"
local_dir="$HOME/.local"

# Set source and modules directories
source_dir="$script_dir/.config"
modules_dir="$script_dir/modules"

# Set log file path
touch "$script_dir/log/installation.log"
log_file="$script_dir/log/installation.log"

# Function to set locales and install on the system
set_locales() {
  local locale="$1"
  LANG="$locale"
  user_lang="${locale:0:2}"

  if ! locale -a | grep -q "$locale"; then
    echo "Installing $locale locale..."
    sudo locale-gen "$locale"
  fi

  if command -v sway &>/dev/null; then
    echo "export LANG=$locale" >> "$config_dir/sway/config"
  fi

  if command -v hyprland &>/dev/null; then
    echo "export LANG=$locale" >> "$config_dir/hyprland/hyprland.conf"
  fi
}

# Prompt user to choose a language
read -p "Choose a language (e.g., fr_FR.UTF-8): " user_locale

# Set locales and install on the system
set_locales "$user_locale"

# Source the messages.sh file
source "$script_dir/messages.sh"

# Install required packages
required_packages=("make" "rsync" "git" "shellcheck" "jq")
missing_packages=()

# Update package list
echo "Updating packages..."
sudo apt-get update -q

# Install package and update logs
install_package() {
  local package="$1"

  if dpkg-query -W -f='${Status}' "$package" 2>/dev/null | grep -q "installed"; then
    echo "$package is already installed."
    echo "$package" >> "$log_file"
    return
  fi

  if [ -f "$modules_dir/$package.sh" ]; then
    source "$modules_dir/$package.sh"
    echo "$package" >> "$log_file"
  else
    echo "$package" >> "$log_file"
  fi
}

# Install packages
for package in "${packages[@]}"; do
  install_package "$package"
done

# Clean up after installation
echo "Cleaning up..."
sudo apt-get autoremove -y

# Display installation logs
dialog --title "Installation Logs" --textbox "$log_file" 20 70

# Remove log file
rm "$log_file"

# Run install_GPU.sh
"$script_dir/install_GPU.sh"
# Run checkXdgPortal.sh
"$script_dir/checkXdgPortal.sh"
# Run sync_to_system.sh
"$script_dir/sync_to_system.sh"

# Reconfigure gdm3
sudo dpkg-reconfigure gdm3