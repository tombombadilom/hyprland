#!/usr/bin/env bash

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

# Variables pour les chemins
config_dir="$HOME/.config"
local_dir="$HOME/.local"
scripts="$HOME/git_config/"
source_dir="$HOME/git_config/.config"
local_source_dir="$HOME/git_config/.local"

# Crée le répertoire de destination s'il n'existe pas
mkdir -p "$local_dir/bin"

# Synchronise les fichiers avec rsync
rsync -av --progress "$local_source_dir/bin/" "$local_dir/bin/"

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
