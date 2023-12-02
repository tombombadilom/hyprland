#!/usr/bin/env bash

# Installer la bibliothèque tqdm si elle n'est pas déjà installée
if ! command -v tqdm &>/dev/null; then
  echo "La bibliothèque tqdm n'est pas installée. Installation en cours..."
  if ! command -v pipx &>/dev/null; then
    # Installer pipx
    sudo apt -y install pipx

    # Ajouter pipx au PATH
    pipx ensurepath
  fi
  pipx install tqdm
fi

# Lista de paquetes
packages=(
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
    "dotenv"
    "dunst"
    "fish"
    "flameshot"
    "foot"
    "grim"
    "hyprpicker"
    "hyprshot"
    "jq"
    "libdisplay-info"
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
    "sway-deps"
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
    "wayland-egl"
    "wayland-protocols"
    "wl-clipboard"
    "wlsunset"
    "waybar"
    "wayland-protocols"
    "wayland-utils"
    "wayfire-deps"
    "wayfire-dev"
    "wayvnc"
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
    # Check if the package is in modules/${package}.json
    if [ -f "modules/${package}.json" ]; then
      alternatives=$(jq -r '.alternatives' "modules/${package}.json")
      # shellcheck disable=SC2164
      cd modules
      # shellcheck disable=SC2086
      ./${package}.sh
      cd ../
    else
      alternatives='{"debian": {}, "ubuntu": {}}'
    fi
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
