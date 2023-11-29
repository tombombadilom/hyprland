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

# Fonction pour afficher la barre de progression
progress_bar() {
  local duration=$1
  # shellcheck disable=SC2155
  local start_time=$(date +%s)
  local end_time=$((start_time + duration))
  local current_time=$start_time

  # shellcheck disable=SC2086
  while [ $current_time -lt $end_time ]; do
    local current=$((current_time - start_time))
    local total=$((end_time - start_time))
    local progress=$((current * 100 / total))
    local filled=$((progress / 2)) # Diviser par 2 pour ajuster à la largeur de 50
    local unfilled=$((50 - filled))
    echo -ne "\r\033[32m["
    for i in $(seq 1 $filled); do echo -n '#'; done
    # shellcheck disable=SC2034
    for i in $(seq 1 $unfilled); do echo -n '-'; done
    echo -ne "\033[0m] $progress%"
    current_time=$(date +%s)
    sleep 1
  done
  echo -e "\n"
}

# Mise à jour de la liste des paquets
echo "Mise à jour des paquets..."
progress_bar 5
sudo apt-get update -q

# Installation du package nécessaire
echo "Installation du package..."
progress_bar 10
# shellcheck disable=SC2102
sudo apt-get install -y [nom_du_package]

# Nettoyage après installation
echo "Nettoyage..."
progress_bar 5
sudo apt-get autoremove -y
sudo apt-get clean

echo "Installation et nettoyage terminés."
