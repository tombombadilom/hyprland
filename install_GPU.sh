#!/usr/bin/env bash

# Mettre à jour la liste des paquets
sudo apt update

# Identifier la carte graphique
GPU_VENDOR=$(lspci | grep -E "VGA|3D" | cut -d ':' -f3 | awk '{print $1}')

# Fonction pour vérifier si un paquet est installé
is_package_installed() {
    dpkg -l "$1" &> /dev/null
}

# Installer le micrologiciel ou le pilote en fonction du fabricant de la carte graphique
case $GPU_VENDOR in
    NVIDIA)
        echo "Vérification du micrologiciel pour NVIDIA"
        if ! is_package_installed "nvidia-driver"; then
            echo "Installation du micrologiciel pour NVIDIA"
            sudo apt install nvidia-driver -y
        else
            echo "Le micrologiciel NVIDIA est déjà installé."
        fi
        ;;
    AMD|Advanced)
        echo "Vérification du micrologiciel pour AMD"
        if ! is_package_installed "firmware-linux" || ! is_package_installed "firmware-linux-nonfree" || ! is_package_installed "libdrm-amdgpu1"; then
            echo "Installation du micrologiciel pour AMD"
            sudo apt install firmware-linux firmware-linux-nonfree libdrm-amdgpu1 -y
        else
            echo "Le micrologiciel AMD est déjà installé."
        fi
        ;;
    Intel)
        echo "Vérification du micrologiciel pour Intel"
        if ! is_package_installed "firmware-linux"; then
            echo "Installation du micrologiciel pour Intel"
            sudo apt install firmware-linux -y
        else
            echo "Le micrologiciel Intel est déjà installé."
        fi
        ;;
    *)
        echo "Fabricant de la carte graphique non reconnu ou pris en charge."
        ;;
esac

# Redémarrer le système
echo "Le système va redémarrer pour appliquer les changements."
sudo reboot
