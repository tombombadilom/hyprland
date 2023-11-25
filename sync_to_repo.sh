#!/usr/bin/env bash

# Script shell to synchronize configuration files
# from the user's ~/.config folder to a git repository
# This script allows to keep track of modifications
# and easily synchronize the configuration across multiple machines and users
<<<<<<< HEAD
#
# Usage: cd $HOME/git_config && ./sync_to_repo.sh
#
# Dependencies: git, rsync, shellcheck
=======
# Usage: ./sync_to_repo.sh
>>>>>>> 144187f925 ( refactor to sync_to_repo.sh)

# Source and target configuration folders
src="$HOME/.config"
local="$HOME/.local"
scripts="$(dirname "$0")"
dest="$scripts/.config"
dest_local="$scripts/.local"

# Identify the Linux distribution and install the appropriate packages
if grep -qEi "(debian|ubuntu)" /etc/*release; then
  os="Debian/Ubuntu"
elif [ -f /etc/arch-release ]; then
  os="Arch"
else
  os="Unknown"
fi

# Load messages from the messages.sh file
<<<<<<< HEAD

# shellcheck source=./messages.sh
# shellcheck disable=SC1091
=======
>>>>>>> 144187f925 ( refactor to sync_to_repo.sh)
source "$scripts/messages.sh"

# Detect the user's language
if [ -z "${LANG}" ]; then
  echo "The system language was not detected."
  echo "Please enter the locale code (e.g., en_US.UTF-8, fr_FR.UTF-8):"
  read -r user_locale
  export LANG="$user_locale"
  user_lang=${user_locale:0:2}
<<<<<<< HEAD
  export user_lang="$user_lang"
=======

>>>>>>> 144187f925 ( refactor to sync_to_repo.sh)
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
  export user_lang="$user_lang"
fi

<<<<<<< HEAD
# Check if rsync, shellcheck, git are installed, install missing packages if necessary
=======
# Check if rsync and git are installed, install missing packages if necessary
>>>>>>> 144187f925 ( refactor to sync_to_repo.sh)
missing_packages=()
if ! command -v rsync &>/dev/null; then
  missing_packages+=("rsync")
fi
if ! command -v git &>/dev/null; then
  missing_packages+=("git")
fi
<<<<<<< HEAD
if ! command -v shellcheck &>/dev/null; then
  missing_packages+=("shellcheck")
fi

# Install missing packages if prompted
if [ ${#missing_packages[@]} -gt 0 ]; then
  get_message "missing_packages"
=======

# Install missing packages if prompted
if [ ${#missing_packages[@]} -gt 0 ]; then
  echo "$(get_message "missing_packages")"
>>>>>>> 144187f925 ( refactor to sync_to_repo.sh)
  read -p "$(get_message "install_missing_packages")" -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ "$os" == "Debian/Ubuntu" ]; then
      sudo apt install -y "${missing_packages[@]}"
    elif [ "$os" == "Arch" ]; then
<<<<<<< HEAD
      yay -Syu "${missing_packages[@]}"
=======
      yay -S "${missing_packages[@]}"
>>>>>>> 144187f925 ( refactor to sync_to_repo.sh)
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
<<<<<<< HEAD
  get_message "missing_packages"
=======
  echo "$(get_message "install_missing_packages")"
>>>>>>> 144187f925 ( refactor to sync_to_repo.sh)
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

<<<<<<< HEAD
# Affichage du message de fin de synchronisation
get_message "sync_completed"
=======
# Display sync completion message
echo "$(get_message "sync_completed")"
>>>>>>> 144187f925 ( refactor to sync_to_repo.sh)
