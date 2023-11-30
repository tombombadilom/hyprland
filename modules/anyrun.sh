#!/usr/bin/env bash

package="anyrun"
log_dir="log"
log_file="$log_dir/$package.log"

# Check if anyrun is already installed
if ! command -v anyrun &> /dev/null
then
    echo "anyrun is not installed. Starting installation..." >> "$log_file"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME"/.cargo/env
    sudo apt install -y libgtk-3-dev libgdk-3-dev libpango1.0-dev libcairo2-dev libgdk-pixbuf2.0-dev libglib2.0-dev
    git clone https://github.com/Kirottu/anyrun.git anyrun
    cd anyrun
    cargo build --release
    cargo install --path anyrun/ -y
    mkdir -p ~/.config/anyrun/plugins
    cp target/release/*.so ~/.config/anyrun/plugins
    cp examples/config.ron ~/.config/anyrun/config.ron
    rustup self uninstall -y
    cd ../
    rm -rf anyrun
    echo "anyrun installation completed successfully." >> "$log_file"
else
    echo "anyrun is already installed" >> "$log_file"
fi

# Add a progress bar for dependencies download and package installation
function progress_bar() {
    local duration=${1}
    local bar_length=50
    local sleep_time=$(bc <<<"scale=2; $duration / $bar_length")
    local progress=0
    local block_char="█"
    local empty_char="░"

    printf "["
    while [ $progress -lt $duration ]; do
        printf "%-${bar_length}s" "${block_char:0:$progress}"
        printf "%-${bar_length}s" "${empty_char:$progress}"
        printf "] "
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
echo "$(date): Running make install" >> "$log_file"
sudo make install

# Uninstall dev libraries
echo "Uninstalling dev libraries..."
sudo apt remove -y libgtk-3-dev libgdk-3-dev libpango1.0-dev libcairo2-dev libgdk-pixbuf2.0-dev libglib2.0-dev

# Installation complete
echo "Installation complete." >> "$log_file"