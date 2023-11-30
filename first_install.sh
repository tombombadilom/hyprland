#!/usr/bin/env bash

# Répertoires de configuration
export config_dir="$HOME/.config"
export local_dir="$HOME/.local"
export scripts="$(dirname "$0")"
export source_dir="$scripts/.config"
export modules_dir="$scripts/modules"

# Paramètres régionaux
export user_locale="en_US.UTF-8"
export LANG="$user_locale"
user_lang=${user_locale:0:2}
export user_lang="$user_lang"

# Mise à jour des fichiers de configuration
if command -v sway &>/dev/null; then
  echo "export LANG=$user_locale" >> "$config_dir/sway/config"
fi

if command -v hyprland &>/dev/null; then
  echo "export LANG=$user_locale" >> "$config_dir/hyprland/hyprland.conf" 
fi

# Messages
source ./messages.sh

# Répertoire de destination
mkdir -p "$local_dir/bin"

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
  if ! [[ " ${installed_packages[*]} " =~ " $package " ]]; then
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
    fi
  fi

  # Barre de progression
  printf "\rProgress : [%-50s] %d%%" $(seq -s= $i 50) $((i*100/total))
  
done

echo "Done!"