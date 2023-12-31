#!/usr/bin/env bash
scripts="$(dirname "$0")"
package="betterlockscreen"
log_dir="$scripts/log"
log_file="$log_dir/$package.log"

echo "Entering $package..." | tee  "$log_file"

install_dependencies() {
    # List of dependencies
    local dependencies=("libcairo2" "libxcb1" "libxcb-dpms0" "libxcb-image0" "libxcb-util0" "libxcb-xinerama0" "libxcb-xkb" "libxcb-xrm" "libxcb-randr0" "libxcb-composite0" "libxcb-keysyms1" "libxkbcommon" "libxkbcommon-x11" "autoconf" "imagemagick" "libev")

    # Total number of dependencies
    local total_dependencies="${#dependencies[@]}"
    # Counter for completed dependencies
    local completed_dependencies=0

    # Uninstall development libraries
    echo "Uninstalling development libraries..." | tee -a "$log_file"
    sudo apt remove -y "${dependencies[@]}"

    for dependency in "${dependencies[@]}"; do
        if ! dpkg -s "$dependency" > /dev/null 2>&1; then
            echo "$dependency is not installed" | tee -a "$log_file"
            sudo apt install -y "$dependency"
            echo "Installed $dependency" | tee -a "$log_file"
        else
            echo "$dependency is already installed" | tee -a "$log_file"
        fi

        completed_dependencies=$((completed_dependencies + 1))
        # Calculate progress percentage
        local progress=$((completed_dependencies * 100 / total_dependencies))
        # Print progress bar
        printf "[%-${total_dependencies}s] %d%%\r" "$(< /dev/zero tr '\0' '=')" "$progress"
    done

    echo
}

check_betterlockscreen_installed() {
    if ! dpkg -s "$package" > /dev/null 2>&1; then
        echo "$package is not installed" | tee -a "$log_file"
        # Additional logic to handle the case when betterlockscreen is not installed
    else
        echo "$package is already installed" | tee -a "$log_file"
    fi
}

clone_i3lock_color() {
    git clone https://github.com/Raymo111/i3lock-color.git
    cd i3lock-color || exit
    autoreconf -i && ./configure && make
    sudo make install
    cd ../
    rm -rf i3lock-color
}

autoinstall_system() {
    wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | sudo bash -s system
}

autoinstall_user() {
    wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | bash -s user
}

remove_dependencies() {
    sudo apt auto-remove -y
}

# Refactored code
install_dependencies
check_betterlockscreen_installed
clone_i3lock_color
autoinstall_system
autoinstall_user
remove_dependencies