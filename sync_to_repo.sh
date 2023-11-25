#!/usr/bin/env bash

# Script shell to synchronize configuration files
# from the user's ~/.config folder to a git repository
# This script allows to keep track of modifications
# and easily synchronize the configuration across multiple machines and users
#
# Usage: cd $HOME/git_config && ./sync_to_repo.sh
#
# Dependencies: git, rsync, shellcheck

# Source and target configuration folders
config_dir="$HOME/.config"
local_dir="$HOME/.local"
scripts_dir="$(dirname "$0")"
dest_dir="$scripts_dir/.config"
dest_local_dir="$scripts_dir/.local"

# Identify the Linux distribution and install the appropriate packages
if grep -qEi "(debian|ubuntu)" /etc/*release; then
  os="Debian/Ubuntu"
elif [ -f /etc/arch-release ]; then
  os="Arch"
else
  os="Unknown"
fi

# Load messages from the messages.sh file
# shellcheck source=./messages.sh
# shellcheck disable=SC1091
source "$scripts_dir/messages.sh"

# Detect the user's language
if [ -z "${LANG}" ]; then
  echo "The system language was not detected."
  echo "Please enter the locale code (e.g., en_US.UTF-8, fr_FR.UTF-8):"
  read -r user_locale
  export LANG="$user_locale"
  user_lang=${user_locale:0:2}
  export user_lang="$user_lang"
  # Update configuration files for Sway, Hyprland, or Wayland
  # Replace paths and commands with the appropriate ones for your system
  if command -v sway &>/dev/null; then
    # For Sway, update the configuration file
    echo "export LANG=$user_locale" >>"$config_dir/sway/config"
    # You may need to restart Sway for the changes to take effect
  fi
  if command -v hyprland &>/dev/null; then
    # For Hyprland, update the configuration file
    echo "export LANG=$user_locale" >>"$config_dir/hyprland/hyprland.conf"
    # You may need to restart Hyprland for the changes to take effect
  fi
  # Add similar commands for Wayland or other window managers here
else
  user_lang=${LANG:0:2}
  export user_lang="$user_lang"
fi

# Check if rsync, shellcheck, git are installed, install missing packages if necessary
missing_packages=()
if ! command -v rsync &>/dev/null; then
  missing_packages+=("rsync")
fi
if ! command -v git &>/dev/null; then
  missing_packages+=("git")
fi
if ! command -v shellcheck &>/dev/null; then
  missing_packages+=("shellcheck")
fi

# Install missing packages if prompted
if [ ${missing_packages[@]} -gt 0 ]; then
  get_message "missing_packages"
  read -p "$(get_message "missing_packages")"
  read -p "$(get_message "install_missing_packages")" -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ "$os" == "Debian/Ubuntu" ]; then
      sudo apt install -y "${created_dirs[@]}"
    elif [ "$os" == "Arch" ]; then
      yay -Syu "${created_dirs[@]}"
    fi
  fi
fi

# Sync directories in $dest_dir and $dest_local_dir
for dir in "${dirs[@]}"; do
  mkdir -p "$dest_dir/$dir"
  mkdir -p "$dest_local_dir/$dir"
  changed_files=$(find "$config_dir/$dir" -type f -newermt "@$last_git_update")
  if [ -n "$changed_files" ]; then
    echo "Modifications found in $dir"
    rsync -a "$config_dir/$dir/" "$dest_dir/$dir/"
    rsync -a "$local_dir/$dir/" "$dest_local_dir/$dir/"
  fi
done

# Display the synchronization completion message
get_message "sync_completed"
