#! /bin/sh
# Always keep this at EOL of hyprland.conf
# Definitely consider increasing sleep time on an underpowered PC
# Start Music at ws4
hyprctl keyword windowrule "workspace 4 silent,foot" && foot ncmpcpp &
#sleep 1 && hyprctl reload
sleep 0.5 && hyprctl reload
hyprctl keyword windowrule "workspace unset,foot" 
