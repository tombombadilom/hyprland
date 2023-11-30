#!/usr/bin/env bash
scripts="$(dirname "$0")"
# shellcheck disable=SC2086
mkdir -p $scripts/log
# Configuration source and target directories
config_dir="$HOME/.config"
local_dir="$HOME/.local"
# shellcheck disable=SC2034
source_dir="$scripts/.config"
modules_dir="$scripts/modules"
# shellcheck disable=SC2154
log_dir="$script/log"
log_file="$log_dir/installation.log"
echo "Entering First install ..." | tee  "$log_file"
# Set user locale
user_locale="en_US.UTF-8"
LANG="$user_locale"
# shellcheck disable=SC2034
user_lang=${user_locale:0:2}

# Update configuration files for Sway, Hyprland, or Wayland
if command -v sway &>/dev/null; then
  echo "export LANG=$user_locale" >> "$config_dir/sway/config"
fi

if command -v hyprland &>/dev/null; then
  echo "export LANG=$user_locale" >> "$config_dir/hyprland/hyprland.conf"
fi

# Load messages from messages.sh file
# shellcheck disable=SC1091
source "$scripts/messages.sh"

# Create destination directory if none exists
mkdir -p "$local_dir/bin"

# Packages to install
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

# Update package list
echo "Updating packages..."
sudo apt-get update -q

# Install packages
total=${#packages[@]}
progress=0

# Function to update progress dialog
update_progress() {
  echo $((progress * 100 / total))
}

# Function to install package and update logs
install_package() {
  package="$1"
  
  # Check if package is already installed
  if dpkg-query -W -f='${Status}' "$package" 2>/dev/null | grep -q "installed"; then
    echo "$package is already installed."
    echo "$package" >> "$log_file"
    return
  fi
  
  if ! sudo apt-get install -y "$package"; then
    if [ -f "$modules_dir/$package.sh" ]; then
      "$modules_dir/$package.sh"
      echo "$package" >> "$log_file"
    else
      echo "$package" >> "$log_file"
    fi
  else
    echo "$package" >> "$log_file"
  fi
  progress=$((progress + 1))
  update_progress | dialog --title "Installation Progress" --gauge "Installing package $package" 7 70
}

# Install packages
for package in "${packages[@]}"; do
  install_package "$package"
done

# Clean up after installation
echo "Cleaning up..."
sudo apt-get autoremove -y

# Display logs
dialog --title "Installation Logs" --textbox "$log_file" 20 70

# Remove log file
rm "$log_file"