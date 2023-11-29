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

# Fichier JSON de suivi des répertoires
json_file="allowed_dirs.json"

# Créer le fichier JSON s'il n'existe pas
if [ ! -f "$json_file" ]; then
  touch "$json_file"
  echo '{ "directories": [] }' > "$json_file"
fi

# Lire l'état actuel à partir du fichier JSON
state=$(cat "$json_file")

# Vérifier s'il y a des modifications dans le répertoire
# shellcheck disable=SC2066
for dir in "${state[directories]}"; do
  # shellcheck disable=SC2295
  dest_local="$dest_local_dir/${dir#$config_dir/}"
  # shellcheck disable=SC2154
  if ! find "$dir" -type f -newer "$dest" -print -quit | grep -q . ; then
    continue
  fi

  # Vérifier si le répertoire local existe déjà
  if [ -d "$dest_local" ]; then
    # Ajouter le répertoire à la liste des nouveaux répertoires
    new_directories+=("$dir")
  fi
done

# Traiter les nouveaux répertoires
for dir in "${new_directories[@]}"; do
  # shellcheck disable=SC2295
  dest_local="$dest_local_dir/${dir#$config_dir/}"

  echo "Synchronisation du répertoire $dir ..."

  # Synchroniser les fichiers du répertoire vers la destination
  rsync -avz --delete "$dir" "$dest"

  # Mettre à jour le fichier JSON avec le nouveau répertoire
  state=$(jq --arg dir "$dest_local" '.directories += [$dir]' <<< "$state")
  echo "$state" > "$json_file"
done

# Supprimer les répertoires en trop
# shellcheck disable=SC2066
for dir in "${state[directories]}"; do
  # shellcheck disable=SC2295
  dest_local="$dest_local_dir/${dir#$config_dir/}"
  if [ ! -d "$dir" ] && [ -d "$dest_local" ]; then
    rm -rf "$dest_local"
    state=$(jq --arg dir "$dest_local" '.directories -= [$dir]' <<< "$state")
    echo "$state" > "$json_file"
  fi
done

# Créer un fichier denials.txt avec les répertoires refusés
echo -n "" > denials.txt
# shellcheck disable=SC2066
for dir in "${state[directories]}"; do
  # shellcheck disable=SC2295
  dest_local="$dest_local_dir/${dir#$config_dir/}"
  # shellcheck disable=SC2076
  # shellcheck disable=SC2199
  if ! [[ " ${new_directories[@]} " =~ " ${dir} " ]]; then
    echo "$dir" >> denials.txt
  fi
done

# Synchroniser les fichiers dans $dest_dir et $dest_local_dir en excluant denials.txt
rsync -avz --delete --exclude='denials.txt' "$dest_dir/" "$config_dir"
rsync -avz --delete --exclude='denials.txt' "$dest_local_dir/" "$local_dir"

echo "Synchronisation terminée."
exit 0