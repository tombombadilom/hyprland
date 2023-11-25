#!/usr/bin/env bash

# Définir les messages dans différentes langues en utilisant des tableaux associatifs
declare -A messages

# Messages existants pour l'autre script
messages["modifications_detected_es"]="Modificaciones detectadas en"
messages["sync_in_progress_en"]="synchronization in progress..."
messages["sync_in_progress_fr"]="synchronisation en cours..."
messages["sync_in_progress_es"]="sincronización en curso..."
messages["new_directories_found_en"]="New directories found in .config:"
messages["new_directories_found_fr"]="Nouveaux répertoires trouvés dans .config :"
messages["new_directories_found_es"]="Nuevos directorios encontrados en .config:"
messages["copy_directories_prompt_en"]="Do you want to copy these directories? (y/n)"
messages["copy_directories_prompt_fr"]="Voulez-vous copier ces répertoires ? (y/n)"
messages["copy_directories_prompt_es"]="¿Quieres copiar estos directorios? (y/n)"
messages["copy_prompt_en"]="Copy"
messages["copy_prompt_fr"]="Copier"
messages["copy_prompt_es"]="Copiar"
messages["directory_copied_en"]="copied."
messages["directory_copied_fr"]="copié."
messages["directory_copied_es"]="copiado."
messages["sync_completed_en"]="Synchronization completed from .config to config"
messages["sync_completed_fr"]="Synchronisation terminée de .config vers config"
messages["sync_completed_es"]="Sincronización completada de .config a config"

# Nouveaux messages pour ce script
messages["missing_packages_en"]="Some required packages are missing. Please install them before continuing."
messages["missing_packages_fr"]="Certains paquets requis sont manquants. Veuillez les installer avant de continuer."
messages["missing_packages_es"]="Faltan algunos paquetes requeridos. Por favor, instálalos antes de continuar."
messages["install_missing_packages_en"]="Do you want to install the missing packages? (y/n)"
messages["install_missing_packages_fr"]="Voulez-vous installer les paquets manquants ? (o/n)"
messages["install_missing_packages_es"]="¿Quieres instalar los paquetes faltantes? (s/n)"
# messages de first_install.sh
# Existing messages for another script
# ...

# New messages for this script
messages["system_language_not_detected_en"]="The system language was not detected."
messages["system_language_not_detected_fr"]="La langue du système n'a pas été détectée."
messages["system_language_not_detected_es"]="No se detectó el idioma del sistema."

messages["enter_locale_code_en"]="Please enter the locale code (e.g., en_US.UTF-8, fr_FR.UTF-8):"
messages["enter_locale_code_fr"]="Veuillez entrer le code de langue (par exemple, en_US.UTF-8, fr_FR.UTF-8) :"
messages["enter_locale_code_es"]="Por favor, introduzca el código de localización (por ejemplo, en_US.UTF-8, fr_FR.UTF-8):"

messages["update_config_for_sway_en"]="Updating configuration file for Sway."
messages["update_config_for_sway_fr"]="Mise à jour du fichier de configuration pour Sway."
messages["update_config_for_sway_es"]="Actualizando el archivo de configuración para Sway."

messages["update_config_for_hyprland_en"]="Updating configuration file for Hyprland."
messages["update_config_for_hyprland_fr"]="Mise à jour du fichier de configuration pour Hyprland."
messages["update_config_for_hyprland_es"]="Actualizando el archivo de configuración para Hyprland."

messages["restart_sway_effect_en"]="You may need to restart Sway for the changes to take effect."
messages["restart_sway_effect_fr"]="Vous devrez peut-être redémarrer Sway pour que les changements prennent effet."
messages["restart_sway_effect_es"]="Puede que necesite reiniciar Sway para que los cambios surtan efecto."

messages["restart_hyprland_effect_en"]="You may need to restart Hyprland for the changes to take effect."
messages["restart_hyprland_effect_fr"]="Vous devrez peut-être redémarrer Hyprland pour que les changements prennent effet."
messages["restart_hyprland_effect_es"]="Puede que necesite reiniciar Hyprland para que los cambios surtan efecto."

messages["rsync_not_installed_en"]="rsync is not installed. Installing..."
messages["rsync_not_installed_fr"]="rsync n'est pas installé. Installation en cours..."
messages["rsync_not_installed_es"]="rsync no está instalado. Instalando..."

messages["git_not_installed_en"]="git is not installed. Installing..."
messages["git_not_installed_fr"]="git n'est pas installé. Installation en cours..."
messages["git_not_installed_es"]="git no está instalado. Instalando..."

messages["shellcheck_not_installed_en"]="shellcheck is not installed. Installing..."
messages["shellcheck_not_installed_fr"]="shellcheck n'est pas installé. Installation en cours..."
messages["shellcheck_not_installed_es"]="shellcheck no está instalado. Instalando..."

# Fonction pour obtenir le message dans la langue appropriée

get_message() {
  local key="${1}_${user_lang}"
  # Retour à la langue anglaise
  # si le message n'est pas défini
  # dans la langue de l'utilisateur
  #
  echo "${messages[$key]:-${messages[${1}_en]}}"
}

# Ask the user for their preferred language
read -p "Please enter your preferred language (fr/en/es): " user_lang
echo
# Check if the user_lang is supported, default to English if not
if [[ ! " ${!messages[@]} " =~ "${user_lang}" ]]; then
  echo "Language not supported, defaulting to English."
  user_lang="en"
fi
