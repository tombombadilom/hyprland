#!/usr/bin/env bash
# Shell script to install sway, hyprland and ewww
# Usage: cd $HOME/git_config && chmod +x+w first_install.sh && ./first_install.sh
# Dependencies: git, rsync, shellcheck
# Configuration source and target directories
export config_dir="$HOME/.config"
export local_dir="$HOME/.local"
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
  # Replace paths and commands with those appropriate for your system
  if command -v sway &>/dev/null; then
    # For Sway, update configuration file
    echo "export LANG=$user_locale" >>~/.config/sway/config
    # You may need to restart Sway for the changes to take effect.
  fi
  if command -v hyprland &>/dev/null; then
    # For Hyprland, update the configuration file
    echo "export LANG=$user_locale" >>~/.config/hyprland/hyprland.conf
    # You may need to restart Hyprland for the changes to take effect.
  fi
  if command -v hyprland &>/dev/null; then
    # For Hyprland, update the configuration file
    echo "export LANG=$user_locale" >>~/.config/hyprland/hyprland.conf
    # You may need to restart Hyprland for the changes to take effect.
  fi
  # Add similar commands here for Wayland or other window managers
else
  user_lang=${LANG:0:2}
  export user_lang="$user_lang"
fi

# Load messages from messages.sh file
# shellcheck source=./messages.sh
# shellcheck disable=SC1091
source ./messages.sh

# Create destination directory if none exists
mkdir -p "$local_dir/bin"

# Check that rsync, git and shellcheck are installed
# If not, install them
required_packages=("make" "rsync" "git" "shellcheck")
missing_packages=()

for package in "${required_packages[@]}"; do
  if ! dpkg -l | grep -q "$package"; then
    # Check if package corresponds to a script file
    if [ -f "${package}.sh" ]; then
      echo "Running ${package}.sh script to install ${package}"
      ./"${package}.sh"
    else
      missing_packages+=("$package")
    fi
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
  os=$BASH_REMATCH
  ;;
esac
export os

# Load packages from packages.json file
required_packages=($(jq -r '.[] | select(.isArchDependant == false) | .name' packages.json))

# Check if packages are installed
missing_packages=()
for package in "$
if command -v hyprland &>/dev/null; then
    # For Hyprland, update the configuration file
    echo "export LANG=$user_locale" >>~/.config/hyprland/hyprland.conf
    # You may need to restart Hyprland for the changes to take effect.
  fi
  # Add similar commands here for Wayland or other window managers
else
  user_lang=${LANG:0:2}
  export user_lang="$user_lang"
fi

# Load messages from messages.sh file
# shellcheck source=./messages.sh
# shellcheck disable=SC1091
source ./messages.sh

# Create destination directory if none exists
mkdir -p "$local_dir/bin"

# Check that rsync, git and shellcheck are installed
# If not, install them
required_packages=("sudo" "vim" "make" "rsync" "git" "shellcheck" "curl" "vim" "jq" "yay" "build-essential) 
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
  os=$BASH_REMATCH
  ;;
esac
export os
# Load packages from packages.json file
required_packages=($(jq -r '.[] | select(.isArchDependant == false) | .name' packages.json))

