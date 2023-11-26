#!/usr/bin/env bash

# Script shell to install sway, hyprland, and ewww

# Usage: cd $HOME/git_config && chmod +x+w first_install.sh && ./first_install.sh

# Dependencies: git, rsync, shellcheck

# Source and target configuration folders
export config_dir="$HOME/.config"
export local_dir="$HOME/.local"
export scripts="$(dirname "$0")"
export source_dir="$scripts/.config"
export local_source_dir="$scripts/.local"

# Détecter la langue de l'utilisateur
if [ -z "${LANG}" ]; then
  echo "The system language was not detected."
  echo "Please enter the locale code (e.g., en_US.UTF-8, fr_FR.UTF-8):"
  read -r user_locale
  export LANG="$user_locale"
  user_lang=${user_locale:0:2}
  export user_lang="$user_lang"
  # Mettre à jour les fichiers de configuration pour Sway, Hyprland, ou Wayland
  # Remplacer les chemins et les commandes par ceux appropriés pour votre système
  if command -v sway &>/dev/null; then
    # Pour Sway, mettez à jour le fichier de configuration
    echo "export LANG=$user_locale" >>~/.config/sway/config
    # Vous devrez peut-être redémarrer Sway pour que les changements prennent effet
  fi
  if command -v hyprland &>/dev/null; then
    # Pour Hyprland, mettez à jour le fichier de configuration
    echo "export LANG=$user_locale" >>~/.config/hyprland/hyprland.conf
    # Vous devrez peut-être redémarrer Hyprland pour que les changements prennent effet
  fi
  # Ajoutez ici des commandes similaires pour Wayland ou d'autres gestionnaires de fenêtres
else
  user_lang=${LANG:0:2}
  export user_lang="$user_lang"
fi
# Installez le package `make` si nécessaire
if ! dpkg -l | grep -q "make"; then
  echo "make is not installed. Installing..."
  sudo apt install -y make
fi

# First load messages from the messages.sh file
# shellcheck source=./messages.sh
# shellcheck disable=SC1091
source ./messages.sh

# Crée le répertoire de destination s'il n'existe pas
mkdir -p "$local_dir/bin"

# Vérifie si rsync, git et shellcheck sont installeés
# Si non, installez-les
if ! command -v rsync &>/dev/null; then
  echo "rsync is not installed. Installing..."
  sudo apt install -y rsync
fi
if ! command -v git &>/dev/null; then
  echo "git is not installed. Installing..."
  sudo apt install -y git
fi
if ! command -v shellcheck &>/dev/null; then
  echo "shellcheck is not installed. Installing..."
  sudo apt install -y shellcheck
fi

# Détecte le système d'exploitation
os=""
case $(grep -oP '(?<=^ID=).+' /etc/os-release) in
  "ubuntu"|"debian"|"arch")
    os=$BASH_REMATCH
    ;;
esac
export os
## Install missing packages


missing_packages=("conky-lua-archers" "dunst" "eww-wayland" "foot" "HybridBar" "micro" "nano" "gtk-3.0" "gtk-4.0" "light" "menus" "mpv" "nitrogen" "wal" "pamac" "paru-bin" "plank" "QMPlay2" "procps" "tint2" "variety" "gtklock" "polybar" "waybar" "volumeicon" "swaync")
packages_to_install=()

for package in "${missing_packages[@]}"; do
  if ! dpkg -l | grep -q "$package"; then
    echo "$package is not installed. Installing..."
    # Utilisez l'API GitHub pour rechercher le dépôt correspondant au package
    repo_url=$(curl -s "https://api.github.com/search/repositories?q=$package" | jq -r '.items[0].html_url')
    if [[ "$repo_url" == null ]]; then
      echo "No repository found for $package."
    else
      # Clonez le dépôt
      git clone "$repo_url"
      # Effectuez les étapes d'installation supplémentaires spécifiques au package
      cd "$(basename "$repo_url" .git)"
      make install
      cd ..
      # Ajoutez le package à la liste des packages à supprimer
      packages_to_install+=("$package")
    fi
  fi
done

# Supprimez les répertoires clonés
for package in "${packages_to_install[@]}"; do
  rm -rf "$package"
done

#   