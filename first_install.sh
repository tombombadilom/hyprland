#!/usr/bin/env bash

# Script shell pour installer sway, hyprland et ewww

# Usage : cd $HOME/git_config && chmod +x+w first_install.sh && ./first_install.sh

# Dépendances : git, rsync, shellcheck

# Répertoires source et cible de configuration
export config_dir="$HOME/.config"
export local_dir="$HOME/.local"
export scripts="$(dirname "$0")"
export source_dir="$scripts/.config"
export local_source_dir="$scripts/.local"

# Détecter la langue de l'utilisateur
if [ -z "${LANG}" ]; then
  echo "La langue du système n'a pas été détectée."
  echo "Veuillez entrer le code de locale (ex: en_US.UTF-8, fr_FR.UTF-8) :"
  read -r user_locale
  export LANG="$user_locale"
  user_lang=${user_locale:0:2}
  export user_lang="$user_lang"
  # Mettre à jour les fichiers de configuration pour Sway, Hyprland, ou Wayland
  # Remplacer les chemins et les commandes par ceux appropriés pour votre système
  if command -v sway &>/dev/null; then
    # Pour Sway, mettre à jour le fichier de configuration
    echo "export LANG=$user_locale" >>~/.config/sway/config
    # Vous devrez peut-être redémarrer Sway pour que les changements prennent effet
  fi
  if command -v hyprland &>/dev/null; then
    # Pour Hyprland, mettre à jour le fichier de configuration
    echo "export LANG=$user_locale" >>~/.config/hyprland/hyprland.conf
    # Vous devrez peut-être redémarrer Hyprland pour que les changements prennent effet
  fi
  # Ajoutez ici des commandes similaires pour Wayland ou d'autres gestionnaires de fenêtres
else
  user_lang=${LANG:0:2}
  export user_lang="$user_lang"
fi

# Charger les messages à partir du fichier messages.sh
# shellcheck source=./messages.sh
# shellcheck disable=SC1091
source ./messages.sh

# Créer le répertoire de destination s'il n'existe pas
mkdir -p "$local_dir/bin"

# Vérifier si rsync, git et shellcheck sont installés
# Sinon, les installer
required_packages=("make" "rsync" "git" "shellcheck")
missing_packages=()

for package in "${required_packages[@]}"; do
  if ! dpkg -l | grep -q "$package"; then
    missing_packages+=("$package")
  fi
done

if [ ${#missing_packages[@]} -gt 0 ]; then
  echo "Installation des packages manquants : ${missing_packages[*]}"
  sudo apt install -y "${missing_packages[@]}"
fi

# Détecter le système d'exploitation
os=""
case $(grep -oP '(?<=^ID=).+' /etc/os-release) in
"ubuntu" | "debian" | "arch")
  os=$BASH_REMATCH
  ;;
esac

export os

# Charger les packages à partir du fichier packages.json
required_packages=($(jq -r '.[] | select(.isArchDependant == false) | .name' packages.json))

# Vérifier si les packages sont installés
missing_packages=()
for package in "${required_packages[@]}"; do
  if ! dpkg -l | grep -q "$package"; then
    missing_packages+=("$package")
  fi
done

# Installer les packages manquants
if [ ${#missing_packages[@]} -gt 0 ]; then
  echo "Installation des packages manquants : ${missing_packages[*]}"
  sudo apt install -y "${missing_packages[@]}"
fi

packages_to_install=()

# Construire et installer les packages
failed_packages=()

for package in "${missing_packages[@]}"; do
  if ! dpkg -l | grep -q "$package"; then
    echo "$package n'est pas installé. Installation..."
    # Utilisez l'API GitHub pour rechercher le dépôt correspondant au package
    repo_url=$(curl -s "https://api.github.com/search/repositories?q=$package" | jq -r '.items[0].html_url')

    if [[ "$repo_url" == null ]]; then
      echo "Aucun dépôt trouvé pour $package."
    else
      # Clonez le dépôt
      git clone "$repo_url"
      # Effectuez les étapes d'installation supplémentaires spécifiques au package
      cd "$(basename "$repo_url" .git)"
      cd $repo_url # prendre le dernier repertoire de l'url
      ./configure
      make install

      if ! make install; then
        failed_packages+=("$package")
      fi

      # Ajoutez le package à la liste des packages à supprimer
      packages_to_install+=("$package")
    fi
  fi
done

# Supprimez les répertoires clonés
for package in "${packages_to_install[@]}"; do
  if dpkg -l | grep -q "$package"; then
    echo "Suppression du répertoire de construction pour $package..."
    rm -rf "$package"
  fi
done

# Install fonts if not already installed
if ! fc-list | grep -q "FiraCode"; then
  echo "La police FiraCode n'est pas installée. Installation..."
  # Installez la police FiraCode
  # Ajoutez ici la commande d'installation
fi

# Étapes de configuration supplémentaires
# Ajoutez ici les étapes de configuration supplémentaires

# Nettoyage
echo "Nettoyage..."
rm -rf "$HOME/git_config"

# Affichage du message de fin
echo "Installation terminée avec succès!"

# Vérification des packages en échec
if [ ${#failed_packages[@]} -gt 0 ]; then
  echo "Les packages suivants n'ont pas pu être construits ou installés :"
  for failed_package in "${failed_packages[@]}"; do
    echo "$failed_package"
  done
fi
