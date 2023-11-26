#!/usr/bin/env bash

# Script shell pour synchroniser les fichiers de configuration
# du dossier ~/.config de l'utilisateur vers un dépôt git
# Ce script permet de suivre les modifications
# et de synchroniser facilement la configuration sur plusieurs machines et utilisateurs
#
# Utilisation : cd $HOME/git_config && ./sync_to_repo.sh
#
# Dépendances : git, rsync, shellcheck, jq

# Source et cible des dossiers de configuration
config_dir="$HOME/.config"
local_dir="$HOME/.local"
scripts_dir="$(dirname "$0")"
dest_dir="$scripts_dir/.config"
dest_local_dir="$scripts_dir/.local"

# Identifier la distribution Linux et installer les paquets appropriés
if grep -qEi "(debian|ubuntu)" /etc/*release; then
  os="Debian/Ubuntu"
  missing_packages=("rsync" "git" "shellcheck" "jq")
  package_manager="apt"
elif [ -f /etc/arch-release ]; then
  os="Arch"
  missing_packages=("rsync" "git" "shellcheck" "jq")
  package_manager="yay"
else
  os="Unknown"
fi

# Installer les paquets manquants si demandé
if [ ${#missing_packages[@]} -gt 0 ]; then
  read -p "Certains paquets sont manquants. Voulez-vous les installer ? (Y/n)" -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ "$os" == "Debian/Ubuntu" ]; then
      sudo "$package_manager" install -y "${missing_packages[@]}"
    elif [ "$os" == "Arch" ]; then
      yay -Syu "${missing_packages[@]}"
    fi
  fi
fi

# Charger le fichier JSON
json_file="$local_dir/share/state.json"
if [ -f "$json_file" ]; then
  state=$(jq -r '.' "$json_file")
else
  state='{"files":[],"directories":[]}'
fi

# Create associative array to store existing directories
declare -A existing_dirs
for dir in "${state[directories]}"; do
  existing_dirs["$dir"]=1
done

# Create set to store existing files
existing_files=()
for file in "${state[files]}"; do
  existing_files+=("$file")
done

# Synchroniser les répertoires dans $dest_dir et $dest_local_dir
find "$config_dir" -type d -not -path "$config_dir/lib/*" -print0 | while IFS= read -r -d '' dir; do
  dest="$dest_dir/${dir#$config_dir/}"
  dest_local="$dest_local_dir/${dir#$config_dir/}"

  # Vérifier si le répertoire est déjà dans le JSON
  if [[ ${existing_dirs[$dest_local]} ]]; then
    continue
  fi

  # Créer les répertoires de destination s'ils n'existent pas
  mkdir -p "$dest"
  mkdir -p "$dest_local"

  # Vérifier s'il y a des modifications dans le répertoire
  if ! find "$dir" -type f -newer "$dest" -print -quit | grep -q .; then
    continue
  fi

  echo "Modifications trouvées dans $dir"

    # Ajouter le répertoire au JSON
    existing_dirs["$dest_local"]=1
  
    # Synchroniser les fichiers modifiés du répertoire source vers le répertoire de destination
    rsync -a "$dir/" "$dest/"
    # Synchroniser les fichiers modifiés du répertoire source vers le répertoire local de destination,
    # en excluant le sous-répertoire 'lib'
    rsync -a --exclude 'lib' "$local_dir/${dir#$config_dir/}/" "$dest_local/"
  done