#!/usr/bin/env bash

packages=("cmake" "meson" "ninja" "doxygen" "qt5-default")

for package in "${packages[@]}"; do
    if ! dpkg -s "$package" >/dev/null 2>&1; then
        sudo apt -y install "$package"
    fi
done

if [ -d "/usr/lib/xdg-desktop-portal-hyprland" ]; then
    echo "xdg-desktop-portal-hyprland est déjà installé dans /usr/lib/xdg-desktop-portal-hyprland"
else
    git clone --recursive https://github.com/hyprwm/xdg-desktop-portal-hyprland
    # shellcheck disable=SC2164
    cd xdg-desktop-portal-hyprland/
    make all
    sudo make install
fi
echo "xdg-desktop-portal-hyprland est maintenant installé dans /usr/lib/xdg-desktop-portal-hyprland"

# Fix for missing Doxygen and QT packages
export DOXYGEN_EXECUTABLE=/usr/bin/doxygen
export CMAKE_PREFIX_PATH=/usr/lib/x86_64-linux-gnu/qt5/
export QT_DIR=/usr/lib/x86_64-linux-gnu/qt5/

# Remove unnecessary packages after compilation
sudo apt -y remove "cmake" "meson" "ninja" "doxygen" "qt5-default"
sudo apt -y autoremove