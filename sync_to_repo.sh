#!/usr/bin/env bash
scripts="$(dirname "$0")"
# shellcheck disable=SC2086
mkdir -p "$scripts/log"
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
# shellcheck disable=SC2154
log_dir="$script/log"
log_file="$log_dir/sync_to_repo.log"

# Fichier JSON de suivi des répertoires
json_file="allowed_dirs.json"
denials_file="denials.json"

echo "Starting synchronisation to repository..." | tee  "$log_file"

# Vérifier si le fichier JSON existe
if [ ! -f "$json_file" ]; then
  # Créer le fichier JSON et le laisser vide
  echo "[]" > "$json_file"
fi

# Vérifier si le fichier de refus existe
if [ ! -f "$denials_file" ]; then
  # Créer le fichier de refus et le laisser vide
  echo "[]" > "$denials_file"
fi

# Lire le contenu actuel du fichier JSON
allowed_dirs=$(cat "$json_file")
denied_dirs=$(cat "$denials_file")

# Vérifier les nouveaux répertoires dans dest_dir
for dir in "$dest_dir"/*; do
  dir_name=$(basename "$dir")
  
  # Vérifier si le répertoire est déjà autorisé
  if ! echo "$allowed_dirs" | jq -e '.[] | select(. == "'"$dir_name"'")' > /dev/null; then
    # Vérifier si le répertoire est déjà refusé
    if ! echo "$denied_dirs" | jq -e '.[] | select(. == "'"$dir_name"'")' > /dev/null; then
      read -p "Le répertoire $dir_name doit-il être autorisé ? (y/n) " authorize
      if [ "$authorize" == "y" ]; then
        # Ajouter le répertoire à la liste des autorisés
        allowed_dirs=$(echo "$allowed_dirs" | jq '. + ["'"$dir_name"'"]')
      else
        # Ajouter le répertoire à la liste des refusés
        denied_dirs=$(echo "$denied_dirs" | jq '. + ["'"$dir_name"'"]')
      fi
    fi
  fi
done

# Enregistrer les modifications dans les fichiers JSON
echo "$allowed_dirs" > "$json_file"
echo "$denied_dirs" > "$denials_file"

# Synchroniser les fichiers dans $dest_dir et $dest_local_dir en excluant denials.txt
rsync -avz --delete --exclude='denials.txt' "$dest_dir/" "$config_dir"
rsync -avz --delete --exclude='denials.txt' "$dest_local_dir/" "$local_dir"

echo "Synchronisation terminée."
exit 0