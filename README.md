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
git clone https://github.com/tombombadilom/hyprland.git hyprland_config
cd hyprland_config
# hyprland Install
chmod +x+w *.sh
./first_install.sh
```

### Packages URL and References

- **anyrun-git**: [https://github.com/AnyRun/AnyRun](^1^)
- **anytype**: [https://github.com/anytypeio/anytype](^2^)
- **archlinux-betterlockscreen**: [https://github.com/pavanjadhaw/archlinux-betterlockscreen](^3^)
- **archlinux-logout**: [https://github.com/AladW/archlinux-logout](^4^)
- **azote**: [https://github.com/nwg-piotr/azote]
- **bc**: [https://github.com/gavinhoward/bc]
- **blueberry**: [https://github.com/linuxmint/blueberry]
- **bluez**: [https://github.com/bluez/bluez]
- **boost**: [https://github.com/boostorg/boost]
- **boost-libs**: [https://github.com/boostorg/boost]
- **cava**: [https://github.com/karlstav/cava]
- **copyq**: [https://github.com/hluk/CopyQ]
- **coreutils**: [https://github.com/coreutils/coreutils]
- **dunst**: [https://github.com/dunst-project/dunst]
- **eww-wayland**: [https://github.com/elkowar/eww]
- **findutils**: [https://github.com/gnulib-modules/findutils]
- **fish**: [https://github.com/fish-shell/fish-shell]
- **foot**: [https://codeberg.org/dnkl/foot]
- **fuzzel**: [https://github.com/AladW/fuzzel]
- **fzf**: [https://github.com/junegunn/fzf]
- **gawk**: [https://git.savannah.gnu.org/cgit/gawk.git]
- **gnome-control-center**: [https://gitlab.gnome.org/GNOME/gnome-control-center]
- **gojq**: [https://github.com/itchyny/gojq]
- **gtk-3.0**: [https://gitlab.gnome.org/GNOME/gtk]
- **gtk-4.0**: [https://gitlab.gnome.org/GNOME/gtk]
- **gtklock**: [https://github.com/AladW/gtklock]
- **gtklock-playerctl-module**: [https://github.com/AladW/gtklock-playerctl-module]
- **gtklock-powerbar-module**: [https://github.com/AladW/gtklock-powerbar-module]
- **gtklock-userinfo-module**: [https://github.com/AladW/gtklock-userinfo-module]
- **hypr**: [https://github.com/hyprstack/hypr]
- **hyprland**: [https://github.com/hyprstack/hyprland]
- **i3**: [https://github.com/i3/i3]
- **ibus**: [https://github.com/ibus/ibus]
- **imagemagick**: [https://github.com/ImageMagick/ImageMagick]
- **libqalculate**: [https://github.com/Qalculate/libqalculate]
- **light**: [https://github.com/haikarainen/light]
- **menus**: [https://github.com/AladW/menus]
- **micro**: [https://github.com/zyedidia/micro]
- **mpv**: [https://github.com/mpv-player/mpv]
- **ncmpcpp**: [https://github.com/ncmpcpp/ncmpcpp]
- **network-manager-applet**: [https://gitlab.gnome.org/GNOME/network-manager-applet]
- **networkmanager**: [https://gitlab.freedesktop.org/NetworkManager/NetworkManager]
- **nlohmann-json**: [https://github.com/nlohmann/json]
- **nwg-bar-bin**: [https://github.com/nwg-piotr/nwg-bar]
- **nwg-displays**: [https://github.com/n

Source :
(1) Arch Linux - Package Search. https://archlinux.org/packages/.
(2) Arch Linux · GitHub. https://github.com/orgs/archlinux/repositories.
(3) Arch Linux · GitHub. https://github.com/archlinux.
(4) arch-linux-packages · GitHub Topics · GitHub. https://github.com/topics/arch-linux-packages.

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
