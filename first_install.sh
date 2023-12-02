#!/usr/bin/env bash

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
log_file="$script_dir/log/installation.log"

# Define user locale
user_locale="en_US.UTF-8"
LANG="$user_locale"
user_lang="${user_locale:0:2}"

# Update configuration files for Sway, Hyprland, or Wayland
if command -v sway &>/dev/null; then
  echo "export LANG=$user_locale" >> "$config_dir/sway/config"
fi

if command -v hyprland &>/dev/null; then
  echo "export LANG=$user_locale" >> "$config_dir/hyprland/hyprland.conf"
fi

# Source the messages.sh file
source "$script_dir/messages.sh"

# Create destination directory if it doesn't exist
mkdir -p "$local_dir/bin"

# Read packages from packages.json
packages=()
while IFS= read -r package; do
  packages+=("$package")
done < <(jq -r '.packages[]' "$script_dir/packages.json")

# Install required packages
required_packages=("make" "rsync" "git" "shellcheck" "yay" "jq")
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

  if ! sudo apt-get install -y "$package"; then
    if [ -f "$modules_dir/$package.sh" ]; then
      "$modules_dir/$package.sh"
      echo "$package" >> "$log_file"
    else
      echo "$package" >> "$log_file"
    fi
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

# Run sync_to_system.sh
"$script_dir/sync_to_system.sh"

# Reconfigure gdm3
sudo dpkg-reconfigure gdm3