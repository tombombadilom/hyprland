#!/usr/bin/env bash

packages=(
  "anyrun-git"
  "anytype"
  "archlinux-betterlockscreen"
  "archlinux-logout"
  "azote"
  "bc"
  "blueberry"
  "bluez"
  "boost"
  "boost-libs"
  "cava"
  "copyq"
  "coreutils"
  "dunst"
  "findutils"
  "fish"
  "fuzzel"
  "fzf"
  "gawk"
  "gnome-control-center"
  "gojq"
  "ibus"
  "imagemagick"
  "libqalculate"
  "light"
  "ncmpcpp"
  "networkmanager"
  "network-manager-applet"
  "nlohmann-json"
  "nwg-bar-bin"
  "nwg-displays"
  "nwg-dock-bin"
  "nwg-dock-hyprland-bin"
  "nwg-drawer-bin"
  "nwg-look-bin"
  "nwg-panel"
  "pavucontrol"
  "plasma-browser-integration"
  "playerctl"
  "procps"
  "python-build"
  "python-desktop-entry-lib"
  "python-pillow"
  "python-poetry"
  "python-pywal"
  "ripgrep"
  "slurp"
  "socat"
  "sox"
  "starship"
  "swaybg"
  "swayidle"
  "ttf-jetbrains-mono"
  "udev"
  "upower"
  "util-linux"
  "wget"
  "wireplumber"
  "wl-clipboard"
  "xorg-xrandr"
  "yad"
)

json_data=()

for package in "${packages[@]}"; do
  url="https://aur.archlinux.org/packages/${package}/"
  response=$(curl -s -o /dev/null -w "%{http_code}" "$url")
  if [[ $response -eq 200 ]]; then
    is_arch_dependant=true
    alternatives='{"debian": {}, "ubuntu": {}}'
  else
    is_arch_dependant=false
    alternatives='{"debian": {}, "ubuntu": {}}'
  fi

  package_data="{\"name\": \"$package\", \"URL\": \"$url\", \"isArchDependant\": $is_arch_dependant, \"alternatives\": $alternatives}"
  json_data+=("$package_data")
done

json_output="["
for ((i = 0; i < ${#json_data[@]}; i++)); do
  json_output+="${json_data[$i]}"
  if [[ $i -ne $((${#json_data[@]} - 1)) ]]; then
    json_output+=","
  fi
done
json_output+="]"

echo "$json_output" >packages.json
