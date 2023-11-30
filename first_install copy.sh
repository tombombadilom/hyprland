#!/usr/bin/env bash

# Configuration source and target directories
export config_dir="$HOME/.config"
export local_dir="$HOME/.local"
# shellcheck disable=SC2155
export scripts="$(dirname "$0")"
export source_dir="$scripts/.config"
export modules_dir="$scripts/modules"

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
# shellcheck disable=SC1091
source ./messages.sh

# Create destination directory if none exists
mkdir -p "$local_dir/bin"
# shellcheck disable=SC2034
packages=(
  "anytype"
  "betterlockscreen"
  "azote"
  "bc"
  "blueberry"
  "bluez"
  "boost"
  "breeze"
  "breeze-gtk"
  "cava"
  "copyq"
  "dmenu"
  "dunst"
  "fish"
  "flameshot"
  "foot"
  "grim"
  "hyprpicker"
  "hyprshot"
  "jq"
  "libinput"
  "libwayland-server0"
  "libinput-gestures"
  "light"
  "mpd"
  "mpv"
  "neofetch"
  "neovim"
  "nmtui"
  "noto-fonts"
  "noto-fonts-cjk"
  "noto-fonts-emoji"
  "noto-fonts-extra"
  "pavucontrol"
  "picom"
  "playerctl"
  "polybar"
  "rofi"
  "sway"
  "swaybg"
  "swayidle"
  "swaylock"
  "swaync"
  "thunar"
  "tint2"
  "ttf-nerd-fonts-symbols"
  "unzip"
  "wayland"
  "wayland-protocols"
  "wl-clipboard"
  "wlsunset"
  "waybar"
  "wayfire"
  "wofi"
  "wtype"
  "wunderlist"
  "xwallpaper"
  "xwayland"
  "zathura"
  "zathura-pdf-mupdf"
  "yad"
)
# Check that required packages are installed
# shellcheck disable=SC2034
required_packages=("make" "rsync" "git" "shellcheck" "yay" "jq") # Add any additional required packages
# shellcheck disable=SC2034
missing_packages=()
# Mise à jour de la liste des paquets
echo "Mise à jour des paquets..."
sudo apt-get update -q

# Installation des packages
total=${#to_install[@]}
for ((i=1; i<=total; i++)); do
  package=${to_install[$i-1]}
  
  sudo apt-get install -y "$package"

  # Vérifier les modules en cas d'échec
  if [ $? -ne 0 ]; then
    if [ -f "$modules_dir/$package.sh" ]; then
      "$modules_dir/$package.sh"
      echo "$package" >> "$installed_packages_module_log"
    else
      echo "$package" >> "$installed_packages_error_log"
    fi
  else
    echo "$package" >> "$installed_packages_log"
  fi

  # Barre de progression
  progress=$((i * 100 / total))
  printf "\rProgress : [==========] %d%%" $progress
done

# Nettoyage après installation
echo "Nettoyage..."
sudo apt-get autoremove -y
sudo apt-get clean

echo "Installation et nettoyage terminés."