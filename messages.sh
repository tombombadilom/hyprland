#!/usr/bin/env bash

declare -A messages

# Messages for the other script
declare -gA messages=(
  ["modifications_detected"]="Modifications detected in"
  ["sync_in_progress"]="Synchronization in progress..."
  ["new_directories_found"]="New directories found in .config:"
  ["copy_directories_prompt"]="Do you want to copy these directories? (y/n)"
  ["copy_prompt"]="Copy"
  ["directory_copied"]="Copied."
  ["sync_completed"]="Synchronization completed from .config to config"
)

# New messages for this script
declare -gA messages=(
  ["missing_packages"]="Some required packages are missing. Please install them before continuing."
  ["install_missing_packages"]="Do you want to install the missing packages? (y/n)"
  ["system_language_not_detected"]="The system language was not detected."
  ["enter_locale_code"]="Please enter the locale code (e.g., en_US.UTF-8, fr_FR.UTF-8):"
  ["update_config_for_sway"]="Updating configuration file for Sway."
  ["update_config_for_hyprland"]="Updating configuration file for Hyprland."
  ["restart_sway_effect"]="You may need to restart Sway for the changes to take effect."
  ["restart_hyprland_effect"]="You may need to restart Hyprland for the changes to take effect."
  ["rsync_not_installed"]="rsync is not installed. Installing..."
  ["git_not_installed"]="git is not installed. Installing..."
  ["shellcheck_not_installed"]="shellcheck is not installed. Installing..."
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
read -rp "Please enter your preferred language (fr/en/es): " user_lang
echo

case "$user_lang" in
fr | en | es)
  echo "Language selected: $user_lang"
  ;;
*)
  echo "Invalid language selected: $user_lang"
  ;;
esac
