#!/usr/bin/ env bash

# Function to get LANG from Sway configuration
get_lang_from_sway_config() {
  local sway_config_file="~/.config/sway/config/file"

  if [[ -f "$sway_config_file" ]]; then
    local lang=$(grep -E "^set \$lang" "$sway_config_file" | awk '{print $3}')
    if [[ -n "$lang" ]]; then
      echo "$lang"
      return 0
    fi
  fi

  return 1
}

# Function to get LANG from Hyprland configuration
get_lang_from_hyprland_config() {
  local hyprland_config_file="~/.config/hypr/hyprland.conf"

  if [[ -f "$hyprland_config_file" ]]; then
    local lang=$(grep -E "^LANG=" "$hyprland_config_file" | cut -d "=" -f 2)
    if [[ -n "$lang" ]]; then
      echo "$lang"
      return 0
    fi
  fi

  return 1
}

# Read the user's preferred language
read -rp "Veuillez entrer votre langue préférée (fr/en/es) : " user_lang
echo

if [[ -z "$user_lang" ]]; then
  # Get LANG from environment variable
  user_lang="$LANG"

  if [[ -z "$user_lang" ]]; then
    # Get LANG from Sway configuration
    user_lang=$(get_lang_from_sway_config)

    if [[ -z "$user_lang" ]]; then
      # Get LANG from Hyprland configuration
      user_lang=$(get_lang_from_hyprland_config)
    fi

    if [[ -z "$user_lang" ]]; then
      echo "La langue n'a pas pu être détectée dans la configuration de Sway ou Hyprland."
      # Prompt de langue ici...
    fi
  fi
fi

# ...

export LANG="$user_lang"
user_lang=${user_lang:0:2}
export user_lang="$user_lang"

# Mettre à jour les fichiers de configuration pour Sway, Hyprland, ou Wayland
# Remplacer les chemins et les commandes par ceux appropriés pour votre système
# Mettre à jour les fichiers de configuration pour Sway, Hyprland, ou Wayland
# Remplacer les chemins et les commandes par ceux appropriés pour votre système
update_config() {
  local config_file="$1"

  if [[ "$config_file" = "~/.config/sway/config" ]]; then
    # Pour Sway, mettez à jour le fichier de configuration
    echo "input * xkb_layout \"$user_lang\"" >>"$config_file"
    echo "exec --no-startup-id setxkbmap $user_lang" >>"$config_file"
  elif [[ "$config_file" = "~/.config/hyprland/hyprland.conf" ]]; then
    # Pour Hyprland, mettez à jour le fichier de configuration
    echo "input-method $user_lang" >>"$config_file"
  else
    echo "Fichier de configuration non pris en charge : $config_file"
  fi

  # Vous devrez peut-être redémarrer le gestionnaire de fenêtres pour que les changements prennent effet
}

if command -v sway &>/dev/null; then
  # Pour Sway, mettez à jour le fichier de configuration
  # input * xkb_layout "fr"
  # mais il peut aussi l'heriter de i3
  # exec --no-startup-id setxkbmap fr
  update_config "~/.config/sway/config"
fi

if command -v hyprland &>/dev/null; then
  # Pour Hyprland, mettez à jour le fichier de configuration
  # input-method fr
  update_config "~/.config/hyprland/hyprland.conf"
fi

# Vérification de la fonctionnalité de la langue
if [[ "$user_lang" = "fr" ]]; then
  echo "La langue française est fonctionnelle."
elif [[ "$user_lang" = "en" ]]; then
  echo "English language is functional."
elif [[ "$user_lang" = "es" ]]; then
  echo "El idioma español está funcional."
else
  echo "La langue sélectionnée n'est pas fonctionnelle."
fi

# Autres commandes ou tâches en fonction de la langue sélectionnée

# Rest of the script
