#!/usr/bin/env bash

declare -A messages

# Messages for the other script
declare -gA messages=(
  ["missing_packages"]="Certains paquets requis sont manquants. Veuillez les installer avant de continuer."
  ["install_missing_packages"]="Voulez-vous installer les paquets manquants ? (o/n)"
  ["system_language_not_detected"]="La langue du système n'a pas été détectée."
  ["enter_locale_code"]="Veuillez entrer le code de langue (par exemple, en_US.UTF-8, fr_FR.UTF-8) :"
  ["update_config_for_sway"]="Mise à jour du fichier de configuration pour Sway."
  ["update_config_for_hyprland"]="Mise à jour du fichier de configuration pour Hyprland."
  ["restart_sway_effect"]="Vous devrez peut-être redémarrer Sway pour que les modifications prennent effet."
  ["restart_hyprland_effect"]="Vous devrez peut-être redémarrer Hyprland pour que les modifications prennent effet."
  ["rsync_not_installed_global"]="rsync n'est pas installé. Installation en cours..."
  ["git_not_installed_global"]="git n'est pas installé. Installation en cours..."
  ["shellcheck_not_installed_global"]="shellcheck n'est pas installé. Installation en cours..."
)

# global messages loaded a bit everwywhere
declare -A messages_global=(
  ["missing_packages_prompt"]="Certains paquets sont manquants. Voulez-vous les installer ? (O/n)"
  ["installing_packages"]="Installation des paquets en cours..."
  ["sync_completed"]="Synchronisation terminée."
  ["sync_failed"]="La synchronisation a échoué."
  ["rsync_not_installed"]="rsync n'est pas installé. Installation en cours..."
  ["git_not_installed"]="git n'est pas installé. Installation en cours..."
  ["shellcheck_not_installed"]="shellcheck n'est pas installé. Installation en cours..."
  ["directory_creation"]="Création du répertoire :"
  ["source_directory_not_found"]="Le répertoire source n'existe pas :"
)

declare -A messages_denials=(
  ["missing_packages"]="Certains paquets sont manquants. Veuillez les installer avant de continuer."
  ["install_missing_packages"]="Voulez-vous installer les paquets manquants ? (o/n)"
  ["permission_denied"]="Accès refusé. Veuillez exécuter le script en tant que root ou avec sudo."
)

# Function to get a message based on the user's preferred language
# Arguments:
#   $1: The message key (e.g., "modifications_detected")
#   $2: The user's preferred language (e.g., "fr", "en", "es")
# Returns:
#   The corresponding message string
get_message() {
  local key="${1}_${2}"
  echo "${messages[$key]:-${messages[${1}_en]}}"
}

# Read the user's preferred language
read -rp "Veuillez entrer votre langue préférée (fr/en/es) : " user_lang
echo

case "$user_lang" in
fr | en | es)
  echo "Langue sélectionnée : $user_lang"
  ;;
*)
  echo "Langue sélectionnée invalide : $user_lang"
  ;;
esac

# Check if the language is functional
if [[ "$user_lang" == "fr" ]]; then
  echo "La langue française est fonctionnelle."
else
  echo "La langue sélectionnée n'est pas fonctionnelle."
fi
