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
