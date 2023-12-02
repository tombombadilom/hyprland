#!/usr/bin/env bash

# Mettre à jour la liste des paquets
sudo apt update

# Fonction pour vérifier si un paquet est installé
is_package_installed() {
    dpkg -l "$1" &> /dev/null
}

# Installer xdg-desktop-portal si nécessaire
if ! is_package_installed "xdg-desktop-portal"; then
    echo "Installation de xdg-desktop-portal..."
    sudo apt install xdg-desktop-portal -y
else
    echo "xdg-desktop-portal est déjà installé."
fi

# Installer xdg-desktop-portal-gtk pour GNOME
if ! is_package_installed "xdg-desktop-portal-gtk"; then
    echo "Installation de xdg-desktop-portal-gtk pour GNOME..."
    sudo apt install xdg-desktop-portal-gtk -y
else
    echo "xdg-desktop-portal-gtk pour GNOME est déjà installé."
fi

# Installer xdg-desktop-portal-wlr pour Sway, Hyprland et Wayfire
if ! is_package_installed "xdg-desktop-portal-wlr"; then
    echo "Installation de xdg-desktop-portal-wlr pour Sway/Hyprland/Wayfire..."
    sudo apt install xdg-desktop-portal-wlr -y
else
    echo "xdg-desktop-portal-wlr pour Sway/Hyprland/Wayfire est déjà installé."
fi

# Redémarrer les services xdg-desktop-portal
echo "Redémarrage des services xdg-desktop-portal..."
systemctl --user daemon-reload
systemctl --user restart xdg-desktop-portal
systemctl --user restart xdg-desktop-portal-gtk
systemctl --user restart xdg-desktop-portal-wlr

echo "Configuration terminée."
