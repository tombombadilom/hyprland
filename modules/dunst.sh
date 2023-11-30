#!/usr/bin/env bash
package="dunst"
log_dir="log"
log_file="$log_dir/$package.log"

echo "Entering $package..." | tee "$log_file"

# Check if dependencies are already installed
dependencies=("dbus" "libxinerama-dev" "libxrandr-dev" "libxss-dev" "libglib2.0-dev" "libpango1.0-dev" "libcairo2-dev" "libnotify-dev" "wayland-client-protocols" "xdg-utils")

for dependency in "${dependencies[@]}"; do
    if dpkg -s "$dependency" &> /dev/null; then
        echo "$dependency is already installed. Skipping installation." | tee -a "$log_file"
    fi
done

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
for dependency in "${dependencies[@]}"; do
    sudo apt remove -y "$dependency"
done

# Log installation completion
echo "dunst installation finished successfully." | tee -a "$log_file"