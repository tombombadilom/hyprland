#!/usr/bin/env bash
package="dunst"
log_dir="log"
log_file="$log_dir/$package.log"

# Check if dunst is already installed
if command -v dunst &> /dev/null; then
    echo "dunst is already installed. Skipping installation."
    exit 0
fi

# Install dependencies
sudo apt install -y dbus libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev libcairo2-dev libnotify-dev wayland-client-protocols xdg-utils

# Clone dunst repository
git clone https://github.com/dunst-project/dunst.git
cd dunst || exit

# Perform make operations with progress bar
make get build 2>&1 | {
    progress=0
    while IFS= read -r line; do
        if [[ "$line" =~ \[.*\]\ (.*)/([0-9]+)% ]]; then
            current_progress="${BASH_REMATCH[2]}"
            if [[ "$current_progress" -gt "$progress" ]]; then
                progress="$current_progress"
                echo "Building dunst: $progress%"
            fi
        fi
    done
}

# Install dunst
sudo make install

# Clean up
cd ../
rm -rf dunst
sudo apt auto-remove -y

# Uninstall dependencies
sudo apt remove -y libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev libcairo2-dev libnotify-dev wayland-client-protocols xdg-utils

# Log installation completion
echo "dunst installation finished successfully." >> "$log_file"