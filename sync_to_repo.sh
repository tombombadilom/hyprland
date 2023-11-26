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
  missing_packages=("rsync" "git" "shellcheck")
  package_manager="apt"
elif [ -f /etc/arch-release ]; then
  os="Arch"
  missing_packages=("rsync" "git" "shellcheck")
  package_manager="yay"
else
  os="Unknown"
fi

# Install missing packages if prompted
if [ ${#missing_packages[@]} -gt 0 ]; then
  read -p "Some packages are missing. Do you want to install them? (Y/n)" -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ "$os" == "Debian/Ubuntu" ]; then
      sudo "$package_manager" install -y "${missing_packages[@]}"
    elif [ "$os" == "Arch" ]; then
      yay -Syu "${missing_packages[@]}"
    fi
  fi
fi

# Sync directories in $dest_dir and $dest_local_dir
for dir in "sway" "hyprland"; do
  mkdir -p "$dest_dir/$dir"
  mkdir -p "$dest_local_dir/$dir"
  changed_files=$(rsync -n --update "$config_dir/$dir/" "$dest_dir/$dir/" | wc -l)
  if [ "$changed_files" -gt 0 ]; then
    echo "Modifications found in $dir"
    rsync -a "$config_dir/$dir/" "$dest_dir/$dir/"
    rsync -a --exclude 'lib' "$local_dir/$dir/" "$dest_local_dir/$dir/"
  fi
done

# Prompt to add new files or directories in $dest_local_dir/bin/
new_files=()
while read -r -d $'\0'; do
  new_files+=("$REPLY")
done < <(find "$dest_local_dir/bin/" -type f -not -path "$dest_local_dir/lib/*" -print0)

if [[ ${#new_files[@]} -gt 0 ]]; then
  rsync -a --exclude 'lib' --files-from=<(printf "%s\n" "${new_files[@]}") "$dest_local_dir/bin/" "$local_dir/"
fi

echo "Synchronization completed."
