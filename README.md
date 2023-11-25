# Git directory to backup and restore my wayland, sway , hyprland config

## Set scripts executables

```bash
cd git_config
sudo chmod +x+w message.sh sync_to_repo.sh sync_to_system.sh
```

## How to use

### First Install

```bash
cd
git clone https://github.com/tombombadilom/hyprland.git git_config
cd git_config
# hyprland Install
```

yay -S conky-lua-archers dunst eww-wayland foot htop hypr hyprland sway i3 rofi HybridBar micro nano gtk-3.0 gtk-4.0 light menus mpv nitrogen wal pamac paru-bin plank QMPlay2 procps tint2 variety gtklock polybar waybar volumeicon swaync

```

```

yay -S anytype anyrun-git ncmpcpp slurp gojq archlinux-betterlockscreen archlinux-logout azote cava copyq

```

```

yay -S nwg-bar-bin nwg-displays nwg-dock-bin nwg-dock-hyprland-bin nwg-drawer-bin nwg-look-bin nwg-panel

```

[https://github.com/end-4/dots-hyprland/tree/hybrid]

```

yay -S python-pywal python-desktop-entry-lib python-poetry python-build python-pillow

```

```

yay -S bc blueberry bluez boost boost-libs coreutils dunst findutils fish fuzzel fzf gawk gnome-control-center ibus imagemagick libqalculate light networkmanager network-manager-applet nlohmann-json pavucontrol plasma-browser-integration playerctl procps ripgrep socat sox starship swaybg swayidle ttf-jetbrains-mono udev upower util-linux xorg-xrandr wget wireplumber wl-clipboard yad

```

```

yay -S ttf-material-symbols-git woff2-material-symbols-git material-black-colors-theme gtk-theme-material-black flat-remix

```

```

yay -S cava geticons gojq gtklock gtklock-playerctl-module gtklock-powerbar-module gtklock-userinfo-module hyprland python-material-color-utilities swww ttf-material-symbols xdg-desktop-portal-hyprland waybar-hyprland wlogout

```



```

### sync sway, hyprland and wayland from git_config repository

```
cd git_config
./sync_to_system.sh
```

### sync sway, hyprland and wayland from system to git

```
cd git_config
./sync_to_repo.sh
```
