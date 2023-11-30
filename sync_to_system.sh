#!/usr/bin/env bash
scripts="$(dirname "$0")"
# shellcheck disable=SC2086
mkdir -p "$scripts/log"
# Variables pour les chemins
config_dir="$HOME/.config"
local_dir="$HOME/.local"
source_dir="$scripts/.config"
local_source_dir="$scripts/.local"
# shellcheck disable=SC2154
log_dir="$script/log"
log_file="$log_dir/sync_to_system.log"

echo "Starting synchronisation to system..." | tee  "$log_file"

# Liste des répertoires à synchroniser
declare -a dirs=("HybridBar" "nwg-displays" "nwg-dock" "nwg-look" "nwg-panel" "gtklock" "my_bar" "nwg-bar" "nwg-dock-hyprland" "swaync" "nwg-drawer" "sway" "paru" "volumeicon")

# Crée le répertoire de destination s'il n'existe pas
mkdir -p "$local_dir/bin"

# Vérifie si rsync, git et shellcheck sont installés
# Si non, installez-les
if ! command -v rsync > /dev/null 2>&1; then
  echo "rsync n'est pas installé. Installation en cours..." | tee -a "$log_file"
  if [ "$(uname)" = "Darwin" ]; then
    brew install rsync
  elif [ -x "$(command -v apt)" ]; then
    sudo apt install -y rsync
  else
    echo "Impossible de trouver un gestionnaire de paquets compatible." | tee -a "$log_file"
    exit 1
  fi
fi

if ! command -v git > /dev/null 2>&1; then
  echo "git n'est pas installé. Installation en cours..." | tee -a "$log_file"
  if [ "$(uname)" = "Darwin" ]; then
    brew install git
  elif [ -x "$(command -v apt)" ]; then
    sudo apt install -y git
  else
    echo "Impossible de trouver un gestionnaire de paquets compatible." | tee -a "$log_file"
    exit 1
  fi
fi

if ! command -v shellcheck > /dev/null 2>&1; then
  echo "shellcheck n'est pas installé. Installation en cours..." | tee -a "$log_file"
  if [ -x "$(command -v apt)" ]; then
    sudo apt install -y shellcheck
  else 
    echo "Impossible de trouver un gestionnaire de paquets compatible." | tee -a "$log_file"
    exit 1
  fi
fi

# Synchronise les fichiers avec rsync
rsync -av --progress --exclude="${dirs[*]}" "$local_dir/bin/" "$local_source_dir/bin/" | tee -a "$log_file"

# Boucle sur chaque répertoire
for dir in "${dirs[@]}"; do
  if [ ! -d "$config_dir/$dir" ]; then
    echo "Création du répertoire : $config_dir/$dir" | tee -a "$log_file"
    mkdir -p "$config_dir/$dir"
  fi

  # Vérifiez si le répertoire source existe avant de copier
  if [ -d "$source_dir/$dir" ]; then
    cp -r "$source_dir/$dir/"* "$config_dir/$dir/" | tee -a "$log_file"
  else
    echo "Le répertoire source $source_dir/$dir n'existe pas." | tee -a "$log_file"
  fi
done

echo "Synchronisation