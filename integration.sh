#!/usr/bin/env bash

# Lista de paquetes
packages=(
  "anytype"
  "betterlockscreen"
  "azote"
  "bc"
  "blueberry"
  "bluez"
  "boost"
  "breeze"
  "breeze-gtk"
  "cava"
  "copyq"
  "dmenu"
  "dunst"
  "fish"
  "flameshot"
  "foot"
  "grim"
  "hyprpicker"
  "hyprshot"
  "jq"
  "libinput"
  "libwayland-server0"
  "libinput-gestures"
  "light"
  "mpd"
  "mpv"
  "neofetch"
  "neovim"
  "nmtui"
  "noto-fonts"
  "noto-fonts-cjk"
  "noto-fonts-emoji"
  "noto-fonts-extra"
  "pavucontrol"
  "picom"
  "playerctl"
  "polybar"
  "rofi"
  "sway"
  "swaybg"
  "swayidle"
  "swaylock"
  "swaync"
  "thunar"
  "tint2"
  "ttf-nerd-fonts-symbols"
  "unzip"
  "wayland"
  "wayland-protocols"
  "wl-clipboard"
  "wlsunset"
  "waybar"
  "wayfire"
  "wofi"
  "wtype"
  "wunderlist"
  "xwallpaper"
  "xwayland"
  "zathura"
  "zathura-pdf-mupdf"
  "yad"
)

# Arreglo para almacenar los datos en formato JSON
json_data=()

# Calcular el número total de paquetes
total_packages=${#packages[@]}

# Inicializar el contador de progreso
progress_counter=0

# Loop sobre los paquetes
for package in "${packages[@]}"; do
  # URL del paquete
  url="https://aur.archlinux.org/packages/${package}/"

  # Realizar la petición HTTP y obtener el código de respuesta
  response=$(curl -s -o /dev/null -w "%{http_code}" "$url")

  # Verificar si el código de respuesta es 200 (éxito)
  if [[ $response -eq 200 ]]; then
    is_arch_dependant=true
    alternatives='{"debian": {}, "ubuntu": {}}'
  else
    is_arch_dependant=false
    alternatives='{"debian": {}, "ubuntu": {}}'
  fi

  # Crear el objeto de datos del paquete en formato JSON
  package_data="{\"name\": \"$package\", \"URL\": \"$url\", \"isArchDependant\": $is_arch_dependant, \"alternatives\": $alternatives}"

  # Agregar el objeto de datos del paquete al arreglo
  json_data+=("$package_data")

  # Incrementar el contador de progreso
  ((progress_counter++))

  # Calcular el porcentaje de progreso
  progress_percentage=$((progress_counter * 100 / total_packages))

  # Imprimir la barra de progreso
  echo "Progreso: $progress_percentage% [$(seq -s '=' $((progress_percentage / 2)) | tr -d '[:digit:]')>$(seq -s ' ' $(((100 - progress_percentage) / 2)) | tr -d '[:digit:]')]"

done

# Convertir el arreglo de datos JSON en una cadena
json_output="["
for ((i = 0; i < ${#json_data[@]}; i++)); do
  json_output+="${json_data[$i]}"
  if [[ $i -ne $((${#json_data[@]} - 1)) ]]; then
    json_output+=","
  fi
done
json_output+="]"

# Guardar la cadena JSON en el archivo packages.json
echo "$json_output" >packages.json
#!/usr/bin/env bash
# Array to change to list :
# [{"name": "anytype", "URL": "https://aur.archlinux.org/packages/anytype/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "betterlockscreen", "URL": "https://aur.archlinux.org/packages/betterlockscreen/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "azote", "URL": "https://aur.archlinux.org/packages/azote/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "bc", "URL": "https://aur.archlinux.org/packages/bc/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "blueberry", "URL": "https://aur.archlinux.org/packages/blueberry/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "bluez", "URL": "https://aur.archlinux.org/packages/bluez/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "boost", "URL": "https://aur.archlinux.org/packages/boost/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "boost-libs", "URL": "https://aur.archlinux.org/packages/boost-libs/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "cava", "URL": "https://aur.archlinux.org/packages/cava/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "copyq", "URL": "https://aur.archlinux.org/packages/copyq/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "coreutils", "URL": "https://aur.archlinux.org/packages/coreutils/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "dunst", "URL": "https://aur.archlinux.org/packages/dunst/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "findutils", "URL": "https://aur.archlinux.org/packages/findutils/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "fish", "URL": "https://aur.archlinux.org/packages/fish/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "fuzzel", "URL": "https://aur.archlinux.org/packages/fuzzel/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "fzf", "URL": "https://aur.archlinux.org/packages/fzf/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "gawk", "URL": "https://aur.archlinux.org/packages/gawk/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "gnome-control-center", "URL": "https://aur.archlinux.org/packages/gnome-control-center/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "gojq", "URL": "https://aur.archlinux.org/packages/gojq/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "hyprland", "URL": "https://aur.archlinux.org/packages/hyprland/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "ibus", "URL": "https://aur.archlinux.org/packages/ibus/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "imagemagick", "URL": "https://aur.archlinux.org/packages/imagemagick/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "libqalculate", "URL": "https://aur.archlinux.org/packages/libqalculate/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "libwayland-server0", "URL": "https://aur.archlinux.org/packages/libwayland-server0/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "light", "URL": "https://aur.archlinux.org/packages/light/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "mako", "URL": "https://aur.archlinux.org/packages/mako/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "ncmpcpp", "URL": "https://aur.archlinux.org/packages/ncmpcpp/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "networkmanager", "URL": "https://aur.archlinux.org/packages/networkmanager/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "network-manager-applet", "URL": "https://aur.archlinux.org/packages/network-manager-applet/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "nlohmann-json", "URL": "https://aur.archlinux.org/packages/nlohmann-json/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "nwg-bar-bin", "URL": "https://aur.archlinux.org/packages/nwg-bar-bin/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "nwg-displays", "URL": "https://aur.archlinux.org/packages/nwg-displays/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "nwg-dock-bin", "URL": "https://aur.archlinux.org/packages/nwg-dock-bin/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "nwg-dock-hyprland-bin", "URL": "https://aur.archlinux.org/packages/nwg-dock-hyprland-bin/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "nwg-drawer-bin", "URL": "https://aur.archlinux.org/packages/nwg-drawer-bin/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "nwg-look-bin", "URL": "https://aur.archlinux.org/packages/nwg-look-bin/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "nwg-panel", "URL": "https://aur.archlinux.org/packages/nwg-panel/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "pavucontrol", "URL": "https://aur.archlinux.org/packages/pavucontrol/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "plasma-browser-integration", "URL": "https://aur.archlinux.org/packages/plasma-browser-integration/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "playerctl", "URL": "https://aur.archlinux.org/packages/playerctl/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "procps", "URL": "https://aur.archlinux.org/packages/procps/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "python-build", "URL": "https://aur.archlinux.org/packages/python-build/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "python-desktop-entry-lib", "URL": "https://aur.archlinux.org/packages/python-desktop-entry-lib/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "python-pillow", "URL": "https://aur.archlinux.org/packages/python-pillow/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "python-poetry", "URL": "https://aur.archlinux.org/packages/python-poetry/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "python-pywal", "URL": "https://aur.archlinux.org/packages/python-pywal/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "ripgrep", "URL": "https://aur.archlinux.org/packages/ripgrep/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "slurp", "URL": "https://aur.archlinux.org/packages/slurp/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "socat", "URL": "https://aur.archlinux.org/packages/socat/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "sox", "URL": "https://aur.archlinux.org/packages/sox/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "starship", "URL": "https://aur.archlinux.org/packages/starship/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "sway", "URL": "https://aur.archlinux.org/packages/sway/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "swaybg", "URL": "https://aur.archlinux.org/packages/swaybg/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "swayidle", "URL": "https://aur.archlinux.org/packages/swayidle/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "ttf-jetbrains-mono", "URL": "https://aur.archlinux.org/packages/ttf-jetbrains-mono/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "udev", "URL": "https://aur.archlinux.org/packages/udev/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "upower", "URL": "https://aur.archlinux.org/packages/upower/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "util-linux", "URL": "https://aur.archlinux.org/packages/util-linux/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "waybar", "URL": "https://aur.archlinux.org/packages/waybar/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "wayland", "URL": "https://aur.archlinux.org/packages/wayland/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "wayland-utils", "URL": "https://aur.archlinux.org/packages/wayland-utils/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "wayfire", "URL": "https://aur.archlinux.org/packages/wayfire/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "wget", "URL": "https://aur.archlinux.org/packages/wget/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "wireplumber", "URL": "https://aur.archlinux.org/packages/wireplumber/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "wl-clipboard", "URL": "https://aur.archlinux.org/packages/wl-clipboard/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "xdg-desktop-portal-hyprland", "URL": "https://aur.archlinux.org/packages/xdg-desktop-portal-hyprland/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "xdg-desktop-portal-wlr", "URL": "https://aur.archlinux.org/packages/xdg-desktop-portal-wlr/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "xorg-xrandr", "URL": "https://aur.archlinux.org/packages/xorg-xrandr/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}},{"name": "yad", "URL": "https://aur.archlinux.org/packages/yad/", "isArchDependant": false, "alternatives": {"debian": {}, "ubuntu": {}}}]

# Installer la bibliothèque tqdm si elle n'est pas déjà installée
if ! command -v tqdm &>/dev/null; then
  echo "La bibliothèque tqdm n'est pas installée. Installation en cours..."
  sudo apt-get -y install python3-pip python3-pipv pv
  # Installer tqdm
  # Installer pipx
  pip install --user pipx
  # Ajouter pipx au PATH
  pipx ensurepath
  # Vérifier l'installation de pipx
  pipx --version
  pip install tqdm
fi
packages=(
  "anytype"
  "betterlockscreen"
  "azote"
  "bc"
  "blueberry"
  "bluez"
  "boost"
  "breeze"
  "breeze-gtk"
  "cava"
  "copyq"
  "dmenu"
  "dunst"
  "fish"
  "flameshot"
  "foot"
  "grim"
  "hyprpicker"
  "hyprshot"
  "jq"
  "libinput"
  "libwayland-server0"
  "libinput-gestures"
  "light"
  "mpd"
  "mpv"
  "neofetch"
  "neovim"
  "nmtui"
  "noto-fonts"
  "noto-fonts-cjk"
  "noto-fonts-emoji"
  "noto-fonts-extra"
  "pavucontrol"
  "picom"
  "playerctl"
  "polybar"
  "rofi"
  "sway"
  "swaybg"
  "swayidle"
  "swaylock"
  "swaync"
  "thunar"
  "tint2"
  "ttf-nerd-fonts-symbols"
  "unzip"
  "wayland"
  "wayland-protocols"
  "wl-clipboard"
  "wlsunset"
  "waybar"
  "wayfire"
  "wofi"
  "wtype"
  "wunderlist"
  "xwallpaper"
  "xwayland"
  "zathura"
  "zathura-pdf-mupdf"
  "yad"
)

json_data=()

# Calculate the total number of packages
total_packages=${#packages[@]}

# Initialize the progress counter
progress_counter=0

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

  # Increment the progress counter
  ((progress_counter++))

  # Calculate the progress percentage
  progress_percentage=$((progress_counter * 100 / total_packages))

  # Print the progress bar
  echo "Progress: $progress_percentage% [$(seq -s '=' $((progress_percentage / 2)) | tr -d '[:digit:]')>$(seq -s ' ' $(((100 - progress_percentage) / 2)) | tr -d '[:digit:]')]"

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
