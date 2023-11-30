package="nwg-dock-hyprland-bin"
log_dir="log"
log_file="$log_dir/$package.log"

# Progress bar
progress_bar() {
    local current=$1
    local total=$2
    local width=50
    local percentage=$((current * 100 / total))
    local completed=$((width * current / total))
    local remaining=$((width - completed))

    printf "\r[%-${completed}s%-${remaining}s] %d%%" \
        "" "" "$percentage"
}

# Check if already installed
if dpkg -s "$package" &> /dev/null; then
    echo "$package is already installed."
else
    echo "Installing $package..."
    sudo apt install -y golang-go libgtk-3-dev libgtk-layer-shell0
    echo "Installation of $package completed."
fi

# Add logs
mkdir -p "$log_dir"
echo "Starting installation process..." >> "$log_file"

git clone https://github.com/nwg-piotr/nwg-dock.git
cd nwg-dock

echo "Getting dependencies..." >> "$log_file"
make get | pv -p -s 100 -N "Progress" -l | progress_bar

echo "Building..." >> "$log_file"
make build | pv -p -s 100 -N "Progress" -l | progress_bar

sudo make install
cd ../
rm -rf nwg-dock
sudo apt -y remove --autoremove golang-go
echo "Uninstallation of golang-go completed." >> "$log_file"

echo "Installation process completed." >> "$log_file"