#!/usr/bin/env bash

# Configuration source and target directories
export config_dir="$HOME/.config"
export local_dir="$HOME/.local"
# shellcheck disable=SC2155
export scripts="$(dirname "$0")"
export source_dir="$scripts/.config"
export local_source_dir="$scripts/.local"

# Detect user language
if [ -z "${LANG}" ]; then
  echo "The system language has not been detected."
  echo "Please enter the locale code (e.g. en_US.UTF-8, fr_FR.UTF-8):"
  read -r user_locale
  export LANG="$user_locale"
  user_lang=${user_locale:0:2}
  export user_lang="$user_lang"

  # Update configuration files for Sway, Hyprland, or Wayland
  if command -v sway &>/dev/null; then
    # For Sway, update configuration file
    echo "export LANG=$user_locale" >>"$config_dir/sway/config"
  fi

  if command -v hyprland &>/dev/null; then
    # For Hyprland, update the configuration file
    echo "export LANG=$user_locale" >>"$config_dir/hyprland/hyprland.conf"
  fi

else
  user_lang=${LANG:0:2}
  export user_lang="$user_lang"
fi

# Load messages from messages.sh file
# shellcheck disable=SC1091
source ./messages.sh

# Create destination directory if none exists
mkdir -p "$local_dir/bin"

# Check that required packages are installed
required_packages=("make" "rsync" "git" "shellcheck")
missing_packages=()

for package in "${required_packages[@]}"; do
  if ! dpkg -l | grep -q "$package"; then
    missing_packages+=("$package")
  fi
done

if [ ${#missing_packages[@]} -gt 0 ]; then
  echo "Installing missing packages: ${missing_packages[*]}"
  sudo apt install -y "${missing_packages[@]}"
fi

# Detect operating system
os=""
case $(grep -oP '(?<=^ID=).+' /etc/os-release) in
"ubuntu" | "debian" | "arch")
  # shellcheck disable=SC2128
  os=$BASH_REMATCH
  ;;
esac
export os

# Load packages from packages.json file
# shellcheck disable=SC2207
required_packages=($(jq -r '.[] | select(.isArchDependant == false) | .name' packages.json))

# Check if packages are installed or they are in modules/.
missing_packages=()
for package in "${required_packages[@]}"; do
  if ! dpkg -l | grep -q "$package"; then
    missing_packages+=("$package")
  fi
  if [ -d "$local_source_dir/$package" ]; then
    cd "$local_source_dir/$package" || exit
    # shellcheck disable=SC2086
    ./$package.sh
    cd ../
  else
    missing_packages+=("$package")
  fi
done

if [ ${#missing_packages[@]} -gt 0 ]; then
  echo "Installing missing packages: ${missing_packages[*]}"
  sudo apt install -y "${missing_packages[@]}"
fi
