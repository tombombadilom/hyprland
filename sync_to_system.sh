#!/usr/bin/env bash

# Script shell pour synchroniser les fichiers de configuration
# depuis le dossier ~/.git_config de l'utilisateur vers le dossier ~/.config de l'utilisateur
# Ce script permet de garder une trace des modifications
# et de synchroniser facilement la configuration sur plusieurs machines et utilisateurs
#
# Usage: cd $HOME/git_config && ./sync_to_system.sh
#
# Dépendances : git, rsync, shellcheck

# Variables pour les chemins
config_dir="$HOME/.config"
local_dir="$HOME/.local"
scripts="$(dirname "$0")"
source_dir="$scripts/.config"
local_source_dir="$scripts/.local"

# Liste des répertoires à synchroniser
declare -a dirs=("HybridBar" "nwg-displays" "nwg-dock" "nwg-look" "nwg-panel" "gtklock" "my_bar" "nwg-bar" "nwg-dock-hyprland" "swaync" "nwg-drawer" "sway" "paru" "volumeicon")

# Crée le répertoire de destination s'il n'existe pas
mkdir -p "$local_dir/bin"

# Vérifie si rsync, git et shellcheck sont installés
# Si non, installez-les
if ! command -v rsync &>/dev/null; then
  echo "rsync n'est pas installé. Installation en cours..."
  # shellcheck disable=SC2154
  if [ "$os" == "Debian/Ubuntu" ]; then
    sudo apt install -y rsync
  elif [ "$os" == "Arch" ]; then
    yay -Syu rsync
  fi
fi

if ! command -v git &>/dev/null; then
  echo "git n'est pas installé. Installation en cours..."
  if [ "$os" == "Debian/Ubuntu" ]; then
    sudo apt install -y git
  elif [ "$os" == "Arch" ]; then
    yay -Syu git
  fi
fi

if ! command -v shellcheck &>/dev/null; then
  echo "shellcheck n'est pas installé. Installation en cours..."
  if [ "$os" == "Debian/Ubuntu" ]; then
    sudo apt install -y shellcheck
  elif [ "$os" == "Arch" ]; then
    yay -Syu shellcheck
  fi
fi

# Synchronise les fichiers avec rsync
rsync -av --progress "$local_dir/bin/" "$local_source_dir/bin/"

# Boucle sur chaque répertoire
for dir in "${dirs[@]}"; do
  if [ ! -d "$config_dir/$dir" ]; then
    echo "Création du répertoire : $config_dir/$dir"
    mkdir -p "$config_dir/$dir"
  fi

  # Vérifiez si le répertoire source existe avant de copier
  if [ -d "$source_dir/$dir" ]; then
    cp -r "$source_dir/$dir/"* "$config_dir/$dir/"
  else
    echo "Le répertoire source $source_dir/$dir n'existe pas."
  fi
done

echo "Synchronisation terminée de config vers .config"
