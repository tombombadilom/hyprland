#!/usr/bin/env bash
# Script shell to synchronize configuration files
# from the user's ~/.git_config folder to the user's ~/.config folder
# This script allows to keep track of modifications
# and easily synchronize the configuration across multiple machines and users
#
# Usage: cd $HOME/git_config && ./sync_to_system.sh
#
# Dependencies: git, rsync, shellcheck
# Variables pour les chemins
config_dir="$HOME/.config"
local_dir="$HOME/.local"
scripts="$(dirname "$0")"
source_dir="$scripts/.config"
local_source_dir="$scripts/.local"

# Liste des répertoires à synchroniser
declare -a dirs=("HybridBar" "nwg-displays" "nwg-dock" "nwg-look" "nwg-panel" "gtklock" "my_bar" "nwg-bar" "nwg-dock-hyprland" "swaync" "nwg-drawer" "sway" "paru" "volumeicon")
declare -a created_dirs=()

# Détection du système d'exploitation
if grep -qEi "(debian|buntu)" /etc/*release; then
  os="Debian/Ubuntu"
elif [ -f /etc/arch-release ]; then
  os="Arch"
else
  os="Unknown"
fi

# Crée le répertoire de destination s'il n'existe pas
mkdir -p "$local_dir/bin"
# Vérifie si rsync, git et shellcheck sont installeés
# Si non, installez-les
if ! command -v rsync &>/dev/null; then
  echo "rsync is not installed. Installing..."
  if [ "$os" == "Debian/Ubuntu" ]; then
    sudo apt install -y rsync
  elif [ "$os" == "Arch" ]; then
    yay -Syu rsync
  fi
fi
if ! command -v git &>/dev/null; then
  echo "git is not installed. Installing..."
  if [ "$os" == "Debian/Ubuntu" ]; then
    sudo apt install -y git
  elif [ "$os" == "Arch" ]; then
    yay -Syu git
  fi
fi
if ! command -v shellcheck &>/dev/null; then
  echo "shellcheck is not installed. Installing..."
  if [ "$os" == "Debian/Ubuntu" ]; then
    sudo apt install -y shellcheck
  elif [ "$os" == "Arch" ]; then
    yay -Syu shellcheck
  fi
fi

# Synchronise les fichiers avec rsync
rsync -av --progress "$local_dir/bin/" "$local_source_dir/bin/"

# Charger les messages depuis le fichier messages.sh
# shellcheck source=./messages.sh
# shellcheck disable=SC1091
source "$scripts/messages.sh"

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

# Boucle sur chaque répertoire
for dir in "${dirs[@]}"; do
  if [ ! -d "$config_dir/$dir" ]; then
    echo "Création du répertoire: $config_dir/$dir"
    mkdir -p "$config_dir/$dir"
    created_dirs+=("$dir")
  fi
  # Vérifiez si le répertoire source existe avant de copier
  if [ -d "$source_dir/$dir" ]; then
    cp -r "$source_dir/$dir/"* "$config_dir/$dir/"
  else
    echo "Le répertoire source $source_dir/$dir n'existe pas."
  fi
done

# Demande de confirmation pour l'installation
if [ ${#created_dirs[@]} -ne 0 ]; then
  echo "Ces applications sont requises mais ne sont pas installées : ${created_dirs[*]}"
  read -p "Voulez-vous installer ces paquets ? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ "$os" == "Debian/Ubuntu" ]; then
      sudo apt install -y "${created_dirs[@]}"
    elif [ "$os" == "Arch" ]; then
      yay -S "${created_dirs[@]}"
    fi
  fi
fi
# Recopie des configurations après l'installation
for dir in "${dirs[@]}"; do
  # Vérifiez si le répertoire source existe avant de copier
  if [ -d "$source_dir/$dir" ]; then
    cp -r "$source_dir/$dir/"* "$config_dir/$dir/"
  else
    echo "Le répertoire source $source_dir/$dir n'existe pas."
  fi
done

echo "Synchronisation terminée de config vers .config"
