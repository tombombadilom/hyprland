# Git directory to backup and restore my wayland, sway , hyprland config

## Set scripts executables

```bashwg-look).
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
- **anyrun-git**: No project found.
- **anytype**: No project found.
- **archlinux-betterlockscreen**: [https://github.com/pavanjadhaw/betterlockscreen](https://github.com/pavanjadhaw/betterlockscreen)⁴.
- **archlinux-logout**: No project found.
- **azote**: [https://github.com/nwg-piotr/azote](https://github.com/nwg-piotr/azote)⁵.
- **bc**: [https://github.com/gavinhoward/bc](https://github.com/gavinhoward/bc).
- **blueberry**: [https://github.com/linuxmint/blueberry](https://github.com/linuxmint/blueberry).
- **bluez**: [https://git.kernel.org/pub/scm/bluetooth/bluez.git](https://git.kernel.org/pub/scm/bluetooth/bluez.git).
- **boost**: [https://github.com/boostorg/boost](https://github.com/boostorg/boost).
- **boost-libs**: [https://github.com/boostorg/boost](https://github.com/boostorg/boost).
- **cava**: [https://github.com/karlstav/cava](https://github.com/karlstav/cava).
- **copyq**: [https://github.com/hluk/CopyQ](https://github.com/hluk/CopyQ).
- **coreutils**: [https://github.com/coreutils/coreutils](https://github.com/coreutils/coreutils).
- **dunst**: [https://github.com/dunst-project/dunst](https://github.com/dunst-project/dunst).
- **findutils**: [https://github.com/gnulib-modules/findutils](https://github.com/gnulib-modules/findutils).
- **fish**: [https://github.com/fish-shell/fish-shell](https://github.com/fish-shell/fish-shell).
- **fuzzel**: No project found.
- **fzf**: [https://github.com/junegunn/fzf](https://github.com/junegunn/fzf)².
- **gawk**: [https://git.savannah.gnu.org/cgit/gawk.git](https://git.savannah.gnu.org/cgit/gawk.git)³.
- **gnome-control-center**: [https://gitlab.gnome.org/GNOME/gnome-control-center](https://gitlab.gnome.org/GNOME/gnome-control-center)⁴.
- **gojq**: [https://github.com/itchyny/gojq](https://github.com/itchyny/gojq)³.
- **ibus**: [https://github.com/ibus/ibus](https://github.com/ibus/ibus)⁵.
- **imagemagick**: [https://github.com/ImageMagick/ImageMagick](https://github.com/ImageMagick/ImageMagick).
- **libqalculate**: [https://github.com/Qalculate/libqalculate](https://github.com/Qalculate/libqalculate).
- **light**: [https://github.com/haikarainen/light](https://github.com/haikarainen/light).
- **ncmpcpp**: [https://github.com/ncmpcpp/ncmpcpp](https://github.com/ncmpcpp/ncmpcpp)¹.
- **networkmanager**: [https://gitlab.freedesktop.org/NetworkManager/NetworkManager](https://gitlab.freedesktop.org/NetworkManager/NetworkManager).
- **network-manager-applet**: [https://gitlab.gnome.org/GNOME/network-manager-applet](https://gitlab.gnome.org/GNOME/network-manager-applet).
- **nlohmann-json**: [https://github.com/nlohmann/json](https://github.com/nlohmann/json).
- **nwg-bar-bin**: [https://github.com/nwg-piotr/nwg-bar](https://github.com/nwg-piotr/nwg-bar).
- **nwg-displays**: [https://github.com/nwg-piotr/nwg-displays](https://github.com/nwg-piotr/nwg-displays).
- **nwg-dock-bin**: [https://github.com/nwg-piotr/nwg-dock](https://github.com/nwg-piotr/nwg-dock).
- **nwg-dock-hyprland-bin**: [https://github.com/nwg-piotr/nwg-dock](https://github.com/nwg-piotr/nwg-dock).
- **nwg-drawer-bin**: [https://github.com/nwg-piotr/nwg-drawer](https://github.com/nwg-piotr/nwg-drawer).
- **nwg-look-bin**: [https://github.com/nwg-piotr/nwg-look](https://github.com/nwg-piotr/nwg-look).
- **nwg-panel**: [https://github.com/nwg-piotr/nwg-panel](https://github.com/nwg-piotr/nwg-panel).
- **pavucontrol**: [https://freedesktop.org/software/pulseaudio/pavucontrol/](https://freedesktop.org/software/pulseaudio/pavucontrol/).
- **plasma-browser-integration**: [https://invent.kde.org/plasma/plasma-browser-integration](https://invent.kde.org/plasma/plasma-browser-integration).
- **playerctl**: [https://github.com/altdesktop/playerctl](https://github.com/altdesktop/playerctl).
- **procps**: [https://gitlab.com/procps-ng/procps](https://gitlab.com/procps-ng/procps).
- **python-build**: [https://github.com/pyenv/pyenv/tree/master/plugins/python-build](https://github.com/pyenv/pyenv/tree/master/plugins/python-build).
- **python-desktop-entry-lib**: [https://github.com/solus-project/desktop-file-utils](https://github.com/solus-project/desktop-file-utils).
- **python-pillow**: [https://github.com/python-pillow/Pillow](https://github.com/python-pillow/Pillow).
- **python-poetry**: [https://github.com/python-poetry/poetry](https://github.com/python-poetry/poetry).
- **python-pywal**: [https://github.com/dylanaraps/pywal](https://github.com/dylanaraps/pywal).
- **ripgrep**: [https://github.com/BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep).
- **slurp**: [https://github.com/emersion/slurp](https://github.com/emersion/slurp)².
- **socat**: [https://github.com/craSH/socat](https://github.com/craSH/socat).
- **sox**: [https://sourceforge.net/projects/sox/](https://sourceforge.net/projects/sox/).
- **starship**: [https://github.com/starship/starship](https://github.com/starship/starship).
- **swaybg**: [https://github.com/swaywm/swaybg](https://github.com/swaywm/swaybg).
- **swayidle**: [https://github.com/swaywm/swayidle](https://github.com/swaywm/swayidle).
- **ttf-jetbrains-mono**: [https://github.com/JetBrains/JetBrainsMono](https://github.com/JetBrains/JetBrainsMono).
- **udev**: [https://github.com/systemd/systemd](https://github.com/systemd/systemd).
- **upower**: [https://gitlab.freedesktop.org/upower/upower](https://gitlab.freedesktop.org/upower/upower).
- **util-linux**: [https://github.com/karelzak/util-linux](https://github.com/karelzak/util-linux).
- **wget**: [https://git.savannah.gnu.org/cgit/wget.git](https://git.savannah.gnu.org/cgit/wget.git).
- **wireplumber**: [https://gitlab.freedesktop.org/pipewire/wireplumber](https://gitlab.freedesktop.org/pipewire/wireplumber).
- **wl-clipboard**: [https://github.com/bugaevc/wl.
- **xorg-xrandr**: [https://gitlab.freedesktop.org/xorg/app/xrandr](https://gitlab.freedesktop.org/xorg/app/xrandr).
- **yad**: [https://github.com/v1cont/yad](https://github.com/v1cont/yad)¹.

He ordenado los elementos según el nombre del proyecto, ignorando los prefijos comunes como "the", "a", etc.

- (1) Arch Linux - Package Search. https://archlinux.org/packages/.
- (2) Arch Linux · GitHub. https://github.com/orgs/archlinux/repositories.
- (3) arch-linux-packages · GitHub Topics · GitHub. https://github.com/topics/arch-linux-packages.
- (4) Arch Linux · GitHub. https://github.com/archlinux.
- (5) GitHub - archlinux/archinstall: Arch Linux installer - https://github.com/archlinux/archinstall.

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
