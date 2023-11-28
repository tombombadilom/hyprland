#!/bin/bash

# Actualizar paquetes
sudo apt update

# Instalar Go si aún no está instalado
if ! command -v go &>/dev/null; then
  echo "Instalando Go..."
  sudo apt install -y golang-go
fi

# Instalar gojq
echo "Instalando gojq..."
go install github.com/itchyny/gojq/cmd/gojq@latest

# Añadir gojq al PATH
echo "Añadiendo gojq al PATH..."
echo "export PATH=\$PATH:$(go env GOPATH)/bin" >>~/.bashrc
source ~/.bashrc

echo "Instalación de gojq completada."
# Limpieza después de la instalación
sudo apt-get autoremove -y # Eliminar paquetes innecesarios
sudo apt-get clean         # Limpiar la caché de paquetes

echo "Instalación y limpieza completadas."
