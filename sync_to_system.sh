#!/usr/bin/env bash

scripts="$(dirname "$0")"
mkdir -p "$scripts/log"

# Variables pour les chemins
config_dir="$HOME/.config"
local_dir="$HOME/.local"
source_dir="$scripts/.config"
local_source_dir="$scripts/.local"
log_dir="$scripts/log"
log_file="$log_dir/sync_to_system.log"

echo "Starting synchronisation to system..." | tee "$log_file"

# Liste des répertoires et fichiers à synchroniser
declare -a dirs=("HybridBar" "nwg-displays" "nwg-dock" "nwg-look" "nwg-panel" "gtklock" "my_bar" "nwg-bar" "nwg-dock-hyprland" "swaync" "nwg-drawer" "sway" "paru" "volumeicon")
files=("wayfire.ini")

# Crée le répertoire de destination s'il n'existe pas
mkdir -p "$local_dir/bin"

# Vérifie si rsync, git et shellcheck sont installés
# Si non, installez-les
install_package() {
  package_name=$1
  echo "$package_name n'est pas installé. Installation en cours..." | tee -a "$log_file"
  if [ "$(uname)" = "Darwin" ]; then
    brew install "$package_name"
  elif [ -x "$(command -v apt)" ]; then
    sudo apt install -y "$package_name"
  else
    echo "Impossible de trouver un gestionnaire de paquets compatible." | tee -a "$log_file"
    exit 1
  fi
}

check_and_install_packages() {
  packages=("$@")
  for package in "${packages[@]}"; do
    if ! command -v "$package" > /dev/null 2>&1; then
      install_package "$package"
    fi
  done
}

check_and_install_packages "rsync" "git" "shellcheck"

# Copie les fichiers avec rsync
rsync -av --progress --delete --exclude="${dirs[*]}" "$local_dir/bin/" "$local_source_dir/bin/" | tee -a "$log_file"

# Copie le contenu des répertoires source vers les répertoires de destination
for dir in "${dirs[@]}"; do
  if [ ! -d "$config_dir/$dir" ]; then
    echo "Création du répertoire : $config_dir/$dir" | tee -a "$log_file"
    mkdir -p "$config_dir/$dir"
  fi

  # Vérifie si le répertoire source existe avant de copier
  if [ -d "$source_dir/$dir" ]; then
    cp -r "$source_dir/$dir" "$config_dir/" | tee -a "$log_file"
  else
    echo "Le répertoire source $source_dir/$dir n'existe pas." | tee -a "$log_file"
  fi
done

# Copie le fichier wayfire.ini s'il existe
if [ -f "$source_dir/wayfire.ini" ]; then
  cp "$source_dir/wayfire.ini" "$config_dir/" | tee -a "$log_file"
else
  echo "Le fichier wayfire.ini n'existe pas dans le répertoire source." | tee -a "$log_file"
fi