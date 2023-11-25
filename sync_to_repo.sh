#!/usr/bin/env bash

# Script shell to synchronize configuration files
# from the user's ~/.config folder to a git repository
# This script allows to keep track of modifications
# and easily synchronize the configuration across multiple machines and users
# Usage: ./sync_to_repo.sh

# Source and target configuration folders
src="$HOME/.config"
local="$HOME/.local"
scripts="$HOME/git_config/"
dest="$HOME/git_config/.config"
dest_local="$HOME/git_config/.local"

# Identify the Linux distribution and install the appropriate packages
if grep -qEi "(debian|ubuntu)" /etc/*release; then
  os="Debian/Ubuntu"
elif [ -f /etc/arch-release ]; then
  os="Arch"
else
  os="Unknown"
fi

# Load messages from the messages.sh file
source "$scripts/messages.sh"

# Detect the user's language
if [ -z "${LANG}" ]; then
  echo "The system language was not detected."
  echo "Please enter the locale code (e.g., en_US.UTF-8, fr_FR.UTF-8):"
  read -r user_locale
  export LANG="$user_locale"
  user_lang=${user_locale:0:2}

  # Update configuration files for Sway, Hyprland, or Wayland
  # Replace paths and commands with the appropriate ones for your system
  if command -v sway &>/dev/null; then
    # For Sway, update the configuration file
    echo "export LANG=$user_locale" >>"$src/sway/config"
    # You may need to restart Sway for the changes to take effect
  fi
  if command -v hyprland &>/dev/null; then
    # For Hyprland, update the configuration file
    echo "export LANG=$user_locale" >>"$src/hyprland/hyprland.conf"
    # You may need to restart Hyprland for the changes to take effect
  fi
  # Add similar commands for Wayland or other window managers here
else
  user_lang=${LANG:0:2}
fi

# Check if rsync and git are installed, install missing packages if necessary
missing_packages=()
if ! command -v rsync &>/dev/null; then
  missing_packages+=("rsync")
fi
if ! command -v git &>/dev/null; then
  missing_packages+=("git")
fi

# Install missing packages if prompted
if [ ${#missing_packages[@]} -gt 0 ]; then
  echo "$(get_message "missing_packages")"
  read -p "$(get_message "install_missing_packages")" -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ "$os" == "Debian/Ubuntu" ]; then
      sudo apt install -y "${missing_packages[@]}"
    elif [ "$os" == "Arch" ]; then
      yay -S "${missing_packages[@]}"
    fi
  fi
fi

# Update the last git update timestamp
cd "$dest" && last_git_update=$(git log -1 --format="%ct")
cd "$dest" || exit
dirs=("nwg-displays" "nwg-dock" "nwg-look" "nwg-panel" "gtklock" "my_bar" "nwg-bar" "nwg-dock-hyprland" "swaync" "nwg-drawer" "sway" "paru" "volumeicon")

# Install missing packages for directories that don't exist
created_dirs=()
for dir in "${dirs[@]}"; do
  if [ ! -d "$dest/$dir" ]; then
    created_dirs+=("$dir")
  fi
done

# Install missing packages if prompted
if [ ${#created_dirs[@]} -gt 0 ]; then
  echo "$(get_message "install_missing_packages")"
  read -p "$(get_message "install_missing_packages")" -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ "$os" == "Debian/Ubuntu" ]; then
      sudo apt install -y "${created_dirs[@]}"
    elif [ "$os" == "Arch" ]; then
      yay -S "${created_dirs[@]}"
    fi
  fi
fi

# Sync directories in $dest and $dest_local
for dir in "${dirs[@]}"; do
  mkdir -p "$dest/$dir"
  mkdir -p "$dest_local/$dir"
  changed_files=$(find "$src/$dir" -type f -newermt "@$last_git_update")
  if [ -n "$changed_files" ]; then
    echo "Modifications found in $dir"
    rsync -a "$src/$dir/" "$dest/$dir/"
    rsync -a "$local/$dir/" "$dest_local/$dir/"
  fi
done

# Display sync completion message
echo "$(get_message "sync_completed")"