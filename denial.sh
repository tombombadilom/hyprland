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
find "$config_dir" -type d -not -path "$config_dir/lib/*" -print0 | while IFS= read -r -d '' dir; do
  dest="$dest_dir/${dir#$config_dir/}"
  dest_local="$dest_local_dir/${dir#$config_dir/}"

  mkdir -p "$dest"
  mkdir -p "$dest_local"

  if ! find "$dir" -type f -newer "$dest" -print -quit | grep -q .; then
    continue
  fi

  echo "Modifications found in $dir"
  rsync -a "$dir/" "$dest/"
  rsync -a --exclude 'lib' "$local_dir/${dir#$config_dir/}/" "$dest_local/"
done

# Prompt to add new files or directories in $dest_local_dir/bin/
new_files=()
while IFS= read -r -d '' file; do
  new_files+=("$file")
done < <(find "$dest_local_dir/bin/" -type f -not -path "$dest_local_dir/lib/*" -print0)

if [[ ${#new_files[@]} -gt 0 ]]; then
  rsync -a --exclude 'lib' --files-from=<(printf "%s\n" "${new_files[@]}") "$dest_local_dir/bin/" "$local_dir/"
fi

# Prompt to add new directories in $dest_local_dir/share/
new_dirs=()
while IFS= read -r -d '' dir; do
  new_dirs+=("$dir")
done < <(find "$dest_local_dir/share/" -type d -not -path "$dest_local_dir/lib/*" -print0)

if [[ ${#new_dirs[@]} -gt 0 ]]; then
  for dir in "${new_dirs[@]}"; do
    read -p "Do you want to add the directory '$dir' to '$local_dir/share'? (Y/n)" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      cp -r "$dir" "$local_dir/share/"
    fi
  done
fi
