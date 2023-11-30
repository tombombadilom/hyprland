#!/usr/bin/env bash
package="betterlockscreen"
log_dir="log"
log_file="$log_dir/$package.log"

install_dependencies() {
    # List of dependencies
    local dependencies=("libpam0g-dev" "libcairo2-dev" "libxcb1-dev" "libxcb-dpms0-dev" "libxcb-image0-dev" "libxcb-util0-dev" "libxcb-xinerama0-dev" "libxcb-xkb-dev" "libxcb-xrm-dev" "libxcb-randr0-dev" "libxcb-composite0-dev" "libxcb-keysyms1-dev" "libxkbcommon-dev" "libxkbcommon-x11-dev" "autoconf" "imagemagick" "libev-dev")

    # Total number of dependencies
    local total_dependencies="${#dependencies[@]}"
    # Counter for completed dependencies
    local completed_dependencies=0

    # Uninstall development libraries
    sudo apt remove -y "${dependencies[@]}"

    for dependency in "${dependencies[@]}"; do
        if ! dpkg -s "$dependency" > /dev/null 2>&1; then
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