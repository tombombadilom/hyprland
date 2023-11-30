#!/bin/sh

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
if ! command -v rsync > /dev/null 2>&1; then
  echo "rsync n'est pas installé. Installation en cours..."
  if [ "$(uname)" = "Darwin" ]; then
    brew install rsync
  elif [ -x "$(command -v apt)" ]; then
    sudo apt install -y rsync
  elif [ -x "$(command -v yum)" ]; then
    sudo yum install -y rsync
  elif [ -x "$(command -v dnf)" ]; then
    sudo dnf install -y rsync
  elif [ -x "$(command -v zypper)" ]; then
    sudo zypper install -y rsync
  else
    echo "Impossible de trouver un gestionnaire de paquets compatible."
    exit 1
  fi
fi

if ! command -v git > /dev/null 2>&1; then
  echo "git n'est pas installé. Installation en cours..."
  if [ "$(uname)" = "Darwin" ]; then
    brew install git
  elif [ -x "$(command -v apt)" ]; then
    sudo apt install -y git
  elif [ -x "$(command -v yum)" ]; then
    sudo yum install -y git
  elif [ -x "$(command -v dnf)" ]; then
    sudo dnf install -y git
  elif [ -x "$(command -v zypper)" ]; then
    sudo zypper install -y git
  else
    echo "Impossible de trouver un gestionnaire de paquets compatible."
    exit 1
  fi
fi

if ! command -v shellcheck > /dev/null 2>&1; then
  echo "shellcheck n'est pas installé. Installation en cours..."
  if [ "$(uname)" = "Darwin" ]; then
    brew install shellcheck
  elif [ -x "$(command -v apt)" ]; then
    sudo apt install -y shellcheck
  else [ -x "$(command -v yum)" ]; then
    echo "Impossible de trouver un gestionnaire de paquets compatible."
    exit 1
  fi
fi

# Synchronise les fichiers avec rsync
rsync -av --progress --exclude="${dirs[*]}" "$local_dir/bin/" "$local_source_dir/bin/"

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