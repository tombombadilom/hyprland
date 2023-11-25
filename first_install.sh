#!/usr/bin/env bash

# Script shell to install sway, huprland and ewww
<<<<<<< HEAD
# Usage: cd $HOME/git_config && chmod +x+w first_install.sh && ./first_install.sh
# This command is used to change the directory to $HOME/git_config,
# make the first_install.sh file executable with read and write permissions,
# and then execute the first_install.sh script.
# git clone https://github.com/tombombadilom/hyprland.git git_config
# Usage: cd $HOME/git_config && chmod +x+w first_install.sh && ./first_install.sh
#
# Dependencies: git, rsync, shellcheck
# Source and target configuration folders
# Set the config directory path
export config_dir
config_dir="$HOME/.config"

# Set the local directory path
export local_dir
local_dir="$HOME/.local"

# Get the directory path of the current script
export scripts
scripts="$(dirname "$0")"

# Set the source directory path relative to the current script
export source_dir
source_dir="$scripts/.config"

# Set the local source directory path relative to the current script
=======
# git clone https://github.com/tombombadilom/hyprland.git git_config
# Usage: cd $HOME/git_config && ./first_install.sh
#
# Dependencies: git, rsync, shellcheck
# Source and target configuration folders
export config_dir
config_dir="$HOME/.config"

export local_dir
local_dir="$HOME/.local"

export scripts
scripts="$(dirname "$0")"

export source_dir
source_dir="$scripts/.config"

>>>>>>> fa8b590e73 (started install script)
export local_source_dir
local_source_dir="$scripts/.local"

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

# use shellcheck to set up all the scripts
shellcheck sync_to_repo.sh sync_to_system.sh message.sh first_install.sh

# start the installation of sway, hyprland and eww
#
