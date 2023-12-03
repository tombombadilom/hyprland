#!/usr/bin/env bash
# shellcheck disable=SC2034
scripts="$(dirname "$0")"
package="eww"
# shellcheck disable=SC2154
log_dir="$script/log"
log_file="$log_dir/$package.log"

echo "Entering $package..." | tee  "$log_file"

# Check if anyrun is already installed
if ! command -v eww  &> /dev/null
then
    echo "eww is not installed. Starting installation..." | tee -a "$log_file"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    # shellcheck disable=SC1091
    source "$HOME"/.cargo/env
    sudo apt install -y libgtk-3-dev libpango1.0-dev libcairo2-dev libgdk-pixbuf2.0-dev
    git clone https://github.com/elkowar/eww.git eww
    # shellcheck disable=SC2164
    cd eww
    cargo build --release
    cargo install --path anyrun/ -y
    mkdir -p ~/.config/eww/plugins
    cp target/release/*.so ~/.config/eww/plugins
    rustup self uninstall -y
    cd ../
    rm -rf eww
    echo "eww installation completed successfully." | tee -a "$log_file"
else
    echo "eww is already installed" | tee -a "$log_file"
fi

# Add a progress bar for dependencies download and package installation
function progress_bar() {
    local duration=${1}
    local bar_length=50
    # shellcheck disable=SC2155
    local sleep_time=$(bc <<<"scale=2; $duration / $bar_length")
    local progress=0
    local block_char="\u2588"
    local empty_char="\u2591"

    printf "["
    # shellcheck disable=SC2086
    while [ $progress -lt $duration ]; do
        printf "%-${bar_length}s" "${block_char:0:$progress}"
        printf "%-${bar_length}s" "${empty_char:$progress}"
        printf "] "
        # shellcheck disable=SC2059
        printf "$progress/$duration"
        progress=$((progress + 1))
        sleep $sleep_time
        printf "\r"
    done

    printf "\n"
}

# Downloading dependencies
echo "Downloading dependencies..."
progress_bar 10

# Make install
echo "Running make install..."
echo "$(date): Running make install" | tee -a "$log_file"
sudo make install

# Uninstall dev libraries
echo "Uninstalling dev libraries..."
sudo apt remove -y libgtk-3-dev libpango1.0-dev libcairo2-dev libgdk-pixbuf2.0-dev

# Installation complete
echo "Installation complete." | tee -a "$log_file"
