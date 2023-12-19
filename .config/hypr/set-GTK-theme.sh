#!/usr/bin/env bash
FILE=hyprland.conf
gnome_schema="org.gnome.desktop.interface"

#!/usr/bin/env bash

gnome_schema="org.gnome.desktop.interface"

# Récupérer les valeurs actuelles
gtk_theme=$(gsettings get $gnome_schema gtk-theme)
icon_theme=$(gsettings get $gnome_schema icon-theme)
cursor_theme=$(gsettings get $gnome_schema cursor-theme)
font_name=$(gsettings get $gnome_schema font-name)

# Enlever les guillemets simples des valeurs
gtk_theme="${gtk_theme//\'/}"
icon_theme="${icon_theme//\'/}"
cursor_theme="${cursor_theme//\'/}"
font_name="${font_name//\'/}"

# Remplacer les valeurs dans le script avec sed
sed -i "s/Your theme/$gtk_theme/g" $FILE
sed -i "s/Your icon theme/$icon_theme/g" $FILE
sed -i "s/Your cursor Theme/$cursor_theme/g" $FILE
sed -i "s/Your font name/$font_name/g" $FILE
