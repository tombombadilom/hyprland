#!/usr/bin/env bash

# Configuration source and target directories
export config_dir="$HOME/.config"
export local_dir="$HOME/.local"
export scripts="$(dirname "$0")"
export source_dir="$scripts/.config"
export modules_source_dir="$scripts/modules"

# Set user locale
export user_locale="en_US.UTF-8"
export LANG="$user_locale"
user_lang=${user_locale:0:2}
export user_lang="$user_lang"

# Update configuration files for Sway, Hyprland, or Wayland
if command -v sway &>/dev/null; then
  echo "export LANG=$user_locale" >>"$config_dir/sway/config"
fi

if command -v hyprland &>/dev/null; then
  echo "export LANG=$user_locale" >>"$config_dir/hyprland/hyprland.conf"
fi

# Load messages from messages.sh file
source ./messages.sh

# Create destination directory if none exists
mkdir -p "$local_dir/bin"

# Check that required packages are installed
required_packages=("make" "rsync" "git" "shellcheck")
missing_packages=()

for package in "${required_packages[@]}"; do
  if ! dpkg -s "$package" &>/dev/null; then
    missing_packages+=("$package")
  fi
done

if [ ${#missing_packages[@]} -gt 0 ]; then
  echo "Installing missing packages: ${missing_packages[*]}"
  sudo apt-get install -y --no-install-recommends "${missing_packages[@]}"
fi

# Detect operating system
os=""
case $(grep -oP '(?<=^ID=).+' /etc/os-release) in
"ubuntu" | "debian" | "arch")
  os=$BASH_REMATCH
  ;;
esac
export os

# Load packages from packages.json file
# shellcheck disable=SC2207
required_packages=($(jq -r '.[] | select(.isArchDependant == false) | .name' packages.json))
missing_packages=()

for package in "${required_packages[@]}"; do
  if ! dpkg -s "$package" &>/dev/null; then
    missing_packages+=("$package")
  fi
  if [ -d "$modules_source_dir/$package.sh" ]; then
    cd "$modules_source_dir/$package" || exit
    # shellcheck disable=SC2086
    ./$package.sh
    cd ../
  else
    missing_packages+=("$package")
  fi
done

if [ ${#missing_packages[@]} -gt 0 ]; then
  echo "Installing missing packages: ${missing_packages[*]}"
  sudo apt-get install -y --no-install-recommends "${missing_packages[@]}"
fi
