#!/usr/bin/env bash

# Répertoire de logs
logs_dir="$scripts/logs"
mkdir -p "$logs_dir"

# Fichiers de log
installed_packages_log="$logs_dir/installed_packages.log"
# shellcheck disable=SC2034
installed_packages_warning_log="$logs_dir/installed_packages_warning.log"
installed_packages_error_log="$logs_dir/installed_packages_error.log"
installed_packages_module_log="$logs_dir/installed_packages_module.log"

# Liste des packages installés
installed_packages=($(dpkg --get-selections | grep -v deinstall | cut -f1))

# Liste des packages à installer
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
)

# Packages à installer
to_install=()

for package in "${packages[@]}"; do
  if ! [[ " ${installed_packages[*]} " =~ $package ]]; then
    to_install+=("$package")
  fi

done

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
  printf "\rProgress : [%-*s] %d%%" $((progress / 2)) "====================" $progress
  
done

echo "Done!"