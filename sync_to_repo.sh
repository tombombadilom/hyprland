#!/usr/bin/env bash

# Script shell pour synchroniser les fichiers de configuration
# depuis le dossier ~/.config de l'utilisateur vers un dépôt git
# Ce script permet de conserver l'historique des modifications
# et de synchroniser facilement la configuration entre plusieurs machines
# et utilisateurs
# Usage : ./sync_to_repo.sh

# Dossiers de configuration source et cible
src="$HOME/.config"
local="$HOME/.local"
scripts="$HOME/git_config/"
dest="$HOME/git_config/.config"
dest_local="$HOME/git_config/.local"

# Identifie la distribution linux et installe les paquets appropriés
if grep -qEi "(debian|buntu)" /etc/*release; then
  os="Debian/Ubuntu"
elif [ -f /etc/arch-release ]; then
  os="Arch"
else
  os="Unknown"
fi

# Charger les messages depuis le fichier messages.sh
source "$scripts/messages.sh"

# Détecter la langue de l'utilisateur
if [ -z "${LANG}" ]; then
  echo "The system language was not detected."
  echo "Please enter the locale code (e.g., en_US.UTF-8, fr_FR.UTF-8):"
  read -r user_locale
  export LANG="$user_locale"
  user_lang=${user_locale:0:2}

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
fi
# vérifie si rsync et git sont installés,
# si non, crée une array pour lister les packets à installer
# si l'array contient au moins un packet,
# fait un seul prompt pour confirmer l'installation des packets manquants
# en fonction de l'os (debian, ubuntu , archlinux) et lancer l'installation
# sinon, affiche un message d'erreur.
# ajoute les messages d'erreur dans messages.sh

# Vérifier si rsync et git sont installés
if ! command -v rsync &>/dev/null; then
  missing_packages+=("rsync")
fi
if ! command -v git &>/dev/null; then
  missing_packages+=("git")
fi

# Afficher les messages d'erreur et quitter le script
if [ ${#missing_packages[@]} -gt 0 ]; then
  echo "$(get_message "missing_packages")"
  exit 1
fi

# Prompt pour confirmer l'installation des packets manquants
if [ ${#missing_packages[@]} -gt 0 ]; then
  read -p "$(get_message "install_missing_packages")" -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ "$os" == "Debian/Ubuntu" ]; then
      sudo apt install -y "${missing_packages[@]}"
    elif [ "$os" == "Arch" ]; then
      sudo pacman -S "${missing_packages[@]}"
    fi
  fi
fi

# Récup/MPL le à jour equitable de la derniere mise à jour git
cd "$dest" && last_git_update=$(git log -1 --format="%ct")
cd "$dest" || exit

# Liste des répertoires à synchroniser
declare -a dirs=("HybridBar" "nwg-displays" "nwg-dock" "nwg-look" "nwg-panel" "gtklock" "my_bar" "nwg-bar" "nwg-dock-hyprland" "swaync" "nwg-drawer" "sway" "paru" "volumeicon")

# verifie si tous les repertoires existent bien dans $dest
# sinon propose d'installer les packages manquants
# fait un seul prompt pour confirmer l'installation des packets manquants
# en fonction de l'os (debian, ubuntu , archlinux) et lancer l'installation
# chaque dir manquant est un packet a installer
for dir in "${dirs[@]}"; do
  if [ ! -d "$dest/$dir" ]; then
    created_dirs+=("$dir")
  fi
done
# Affiche un seul prompt pour confirmer l'installation des packets manquants
# en fonction de l'os (debian, ubuntu , archlinux) et lancer l'installation
if [ ${#created_dirs[@]} -gt 0 ]; then
  read -p "$(get_message "install_missing_packages")" -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ "$os" == "Debian/Ubuntu" ]; then
      sudo apt install -y "${created_dirs[@]}"
    elif [ "$os" == "Arch" ]; then
      yay -S "${created_dirs[@]}"
    fi
  fi
fi

# Fait la syncro rsync de config $src vers $dest
# puis de $local vers $dest_local
# Synchroniser les répertoires connus
# Vérifier si des fichiers ont été modifiés ou ajoutés depuis la dernière mise à jour git
# Trouver et proposer de copier les nouveaux répertoires
# Synchroniser les répertoires manquants

# Synchroniser les répertoires connus dans $dest et $dest_local
for dir in "${dirs[@]}"; do
  if [ ! -d "$dest/$dir" ]; then
    mkdir -p "$dest/$dir"
  fi
  if [ ! -d "$dest_local/$dir" ]; then
    mkdir -p "$dest_local/$dir"
  fi
  changed_files=$(find "$src/$dir" -type f -newermt "@$last_git_update")
  if [ -n "$changed_files" ]; then
    echo "Des modifications：
    cp -r "$src/$dir/"* "$dest/$dir/"
    cp -r "$local/$dir/"* "$dest_local/$dir/"
  fi
done

# Affiche le message de fin de syncro

echo "$(get_message "sync_completed")"

# Affiche le message de fin de syncro

echo "$(get_message "sync_completed")"