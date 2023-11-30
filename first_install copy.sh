#!/usr/bin/env bash

# Configuration source and target directories
config_dir="$HOME/.config"
local_dir="$HOME/.local"
scripts="$(dirname "$0")"
# shellcheck disable=SC2034
source_dir="$scripts/.config"
modules_dir="$scripts/modules"
log_file="$scripts/log/installation_log.txt"

# Set user locale
user_locale="en_US.UTF-8"
LANG="$user_locale"
user_lang=${user_locale:0:2}
user_lang="$user_lang"

# Update configuration files for Sway, Hyprland, or Wayland
if command -v sway &>/dev/null; then
  echo "export LANG=$user_locale" >> "$config_dir/sway/config"
fi

if command -v hyprland &>/dev/null; then
  echo "export LANG=$user_locale" >> "$config_dir/hyprland/hyprland.conf"
fi

# Load messages from messages.sh file
source "$scripts/messages.sh"

# Create destination directory if none exists
mkdir -p "$local_dir/bin"

# Packages to install
packages=(
  "dialog"
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
required_packages=("dialog" "make" "rsync" "git" "shellcheck" "yay" "jq") # Add any additional required packages

# Update package list
echo "Updating packages..."
sudo apt-get update -q

# Install required packages
for package in "${required_packages[@]}"; do
  if ! sudo apt-get install -y "$package"; then
    echo "$package" >> "$log_file"
  else
    echo "$package" >> "$log_file"
  fi
done

# Install packages
for package in "${packages[@]}"; do
  if ! sudo apt-get install -y "$package"; then
    if [ -f "$modules_dir/$package.sh" ]; then
      "$modules_dir/$package.sh"
      echo "$package" >> "$log_file"
    else
      echo "$package" >> "$log_file"
    fi
  fi
      
  progress=$((progress + 1))
  if ((progress % 10 == 0)); then
    printf "\rProgress : [==========] %d%%" $((progress * 100 / total))
  fi
done
      
# Clean up after installation
echo "Cleaning up..."
sudo apt-get autoremove