# Git directory to backup and restore my wayland, sway , hyprland config

## Set scripts executables

```bashwg-look).
sudo git clone https://github.com/tombombadilom/hyprland.git hyprlnad
cd hyprland
sudo chmod +x+w message.sh sync_to_repo.sh sync_to_system.sh
```

## How to use

### First Install

```bash
cd
git clone https://github.com/tombombadilom/hyprland.git hyprland
cd hyprland
# hyprland Install
chmod +x+w *.sh
./first_install.sh
```

## Packet equivalence table

| **Nom**                     | **URL Github**                                                            | **Debian Bookworm** | **Ubuntu Luna/Mantic** |
| --------------------------- | ------------------------------------------------------------------------- | ------------------- | ---------------------- |
| anyrun-git                  | [Github](https://github.com/anyrun/anyrun-git)                            | ❌                  | ❌                     |
| anytype                     | [Github](https://github.com/anytypeio/anytype)                            | ❌                  | ❌                     |
| archlinux-betterlockscreen  | [Github](https://github.com/pavanjadhaw/archlinux-betterlockscreen)       | ❌                  | ❌                     |
| archlinux-logout            | [Github](https://github.com/Thermi/ArchLinux-Logout)                      | ❌                  | ❌                     |
| azote                       | [Github](https://github.com/nwg-piotr/azote)                              | ✅ ¹                | ✅ ¹                   |
| bc                          | [Github](https://github.com/gavinhoward/bc)                               | ✅ ²                | ✅ ²                   |
| blueberry                   | [Github](https://github.com/linuxmint/blueberry)                          | ✅ ³                | ✅ ³                   |
| bluez                       | [Github](https://github.com/bluez/bluez)                                  | ✅ ⁴                | ✅ ⁴                   |
| boost                       | [Github](https://github.com/boostorg/boost)                               | ✅ ⁵                | ✅ ⁵                   |
| boost-libs                  | [Github](https://github.com/boostorg/boost)                               | ✅ ⁵                | ✅ ⁵                   |
| cava                        | [Github](https://github.com/karlstav/cava)                                | ❌                  | ❌                     |
| copyq                       | [Github](https://github.com/hluk/CopyQ)                                   | ✅ ⁶                | ✅ ⁶                   |
| coreutils                   | [Github](https://github.com/coreutils/coreutils)                          | ✅ ⁷                | ✅ ⁷                   |
| dunst                       | [Github](https://github.com/dunst-project/dunst)                          | ✅ ⁸                | ✅ ⁸                   |
| findutils                   | [Github](https://github.com/gnulib/findutils)                             | ✅ ⁹                | ✅ ⁹                   |
| fish                        | [Github](https://github.com/fish-shell/fish-shell)                        | ✅ [^10^]           | ✅ [^10^]              |
| fuzzel                      | [Github](https://github.com/AlxHnr/fuzzel)                                | ❌                  | ❌                     |
| fzf                         | [Github](https://github.com/junegunn/fzf)                                 | ✅ ¹¹               | ✅ ¹¹                  |
| gawk                        | [Github](https://github.com/onetrueawk/awk)                               | ✅ ¹²               | ✅ ¹²                  |
| gnome-control-center        | [Github](https://github.com/GNOME/gnome-control-center)                   | ✅                  | ✅                     |
| gojq                        | [Github](https://github.com/itchyny/gojq)                                 | ❌                  | ❌                     |
| hyprland                    | [Github](https://github.com/nwg-piotr/hyprland)                           | ❌                  | ❌                     |
| ibus                        | [Github](https://github.com/ibus/ibus)                                    | ✅                  | ✅                     |
| imagemagick                 | [Github](https://github.com/ImageMagick/ImageMagick)                      | ✅                  | ✅                     |
| libqalculate                | [Github](https://github.com/Qalculate/libqalculate)                       | ✅                  | ✅                     |
| light                       | [Github](https://github.com/haikarainen/light)                            | ✅                  | ✅                     |
| mako                        | [Github](https://github.com/emersion/mako)                                | ✅                  | ✅                     |
| ncmpcpp                     | [Github](https://github.com/ncmpcpp/ncmpcpp)                              | ✅                  | ✅                     |
| networkmanager              | [Github](https://github.com/NetworkManager/NetworkManager)                | ✅                  | ✅                     |
| network-manager-applet      | [Github](https://github.com/NetworkManager/network-manager-applet)        | ✅                  |
| network-manager-applet      | [Github](https://github.com/NetworkManager/network-manager-applet)        | ❌                  | ❌                     |
| nlohmann-json               | [Github](https://github.com/nlohmann/json)                                | ✅ ¹                | ✅ ¹                   |
| nwg-bar-bin                 | [Github](https://github.com/nwg-piotr/nwg-bar)                            | ❌                  | ❌                     |
| nwg-displays                | [Github](https://github.com/nwg-piotr/nwg-displays)                       | ❌                  | ❌                     |
| nwg-dock-bin                | [Github](https://github.com/nwg-piotr/nwg-dock)                           | ❌                  | ❌                     |
| nwg-dock-hyprland-bin       | [Github](https://github.com/nwg-piotr/nwg-dock)                           | ❌                  | ❌                     |
| nwg-drawer-bin              | [Github](https://github.com/nwg-piotr/nwg-drawer)                         | ❌                  | ❌                     |
| nwg-look-bin                | [Github](https://github.com/nwg-piotr/nwg-look)                           | ❌                  | ❌                     |
| nwg-panel                   | [Github](https://github.com/nwg-piotr/nwg-panel)                          | ❌                  | ❌                     |
| pavucontrol                 | [Github](https://github.com/pulseaudio/pavucontrol)                       | ✅ ²                | ✅ ²                   |
| plasma-browser-integration  | [Github](https://github.com/KDE/plasma-browser-integration)               | ✅ ³                | ✅ ³                   |
| playerctl                   | [Github](https://github.com/altdesktop/playerctl)                         | ✅ ⁴                | ✅ ⁴                   |
| procps                      | [Github](https://gitlab.com/procps-ng/procps)                             | ✅ ⁵                | ✅ ⁵                   |
| python-build                | [Github](https://github.com/pyenv/pyenv/tree/master/plugins/python-build) | ✅ ⁶                | ✅ ⁶                   |
| python-desktop-entry-lib    | [Github](https://github.com/solus-project/python-desktop-entry)           | ❌                  | ❌                     |
| python-pillow               | [Github](https://github.com/python-pillow/Pillow)                         | ✅ ⁷                | ✅ ⁷                   |
| python-poetry               | [Github](https://github.com/python-poetry/poetry)                         | ✅ ⁸                | ✅ ⁸                   |
| python-pywal                | [Github](https://github.com/dylanaraps/pywal)                             | ✅ ⁹                | ✅ ⁹                   |
| ripgrep                     | [Github](https://github.com/BurntSushi/ripgrep)                           | ✅ [^10^]           | ✅ [^10^]              |
| slurp                       | [Github](https://github.com/emersion/slurp)                               | ❌                  | ❌                     |
| socat                       | [Github](https://github.com/craSH/socat)                                  | ✅ ¹¹               | ✅ ¹¹                  |
| sox                         | [Github](https://github.com/chirlu/sox)                                   | ✅ ¹²               | ✅ ¹²                  |
| starship                    | [Github](https://github.com/starship/starship)                            | ✅                  | ✅                     |
| sway                        | [Github](https://github.com/swaywm/sway)                                  | ✅                  | ✅                     |
| swaybg                      | [Github](https://github.com/swaywm/swaybg)                                | ✅                  | ✅                     |
| swayidle                    | [Github](https://github.com/swaywm/swayidle)                              | ✅                  | ✅                     |
| ttf-jetbrains-mono          | [Github](https://github.com/JetBrains/JetBrainsMono)                      | ✅                  | ✅                     |
| udev                        | [Github](https://github.com/systemd/systemd)                              | ✅                  | ✅                     |
| upower                      | [Github](https://gitlab.freedesktop.org/upower/upower)                    | ✅                  | ✅                     |
| util-linux                  | [Github](https://github.com/karelzak/util-linux)                          | ✅ ¹                | ✅ ¹                   |
| waybar                      | [Github](https://github.com/Alexays/Waybar)                               | ❌                  | ❌                     |
| wayland                     | [Github](https://github.com/wayland-project/wayland)                      | ✅ ²                | ✅ ²                   |
| wget                        | [Github](https://github.com/mirror/wget)                                  | ✅ ³                | ✅ ³                   |
| wireplumber                 | [Github](https://github.com/wireplumber/wireplumber)                      | ❌                  | ❌                     |
| wl-clipboard                | [Github](https://github.com/bugaevc/wl-clipboard)                         | ❌                  | ❌                     |
| wlroots                     | [Github](https://github.com/swaywm/wlroots)                               | ✅ ⁴                | ✅ ⁴                   |
| xdg-desktop-portal-hyprland | [Github](https://github.com/nwg-piotr/xdg-desktop-portal-hyprland)        | ❌                  | ❌                     |
| xdg-desktop-portal-wlr      | [Github](https://github.com/emersion/xdg-desktop-portal-wlr)              | ❌                  | ❌                     |
| xorg-xrandr                 | [Github](https://gitlab.freedesktop.org/xorg/app/xrandr)                  | ✅ ⁵                | ✅ ⁵                   |
| yad                         | [Github](https://github.com/v1cont/yad)                                   | ❌                  | ❌                     |

**Arch Linux** :

- 1. [Arch Linux - Package Search]
- 2. [Create A List Of Installed Packages And Install Them Later ... - OSTechNix]
- 3. [Arch Linux Forums - Generating a List of Installed Packages / Newbie]
- 4. [List of applications - ArchWiki]
- 5. [pacman/Tips and tricks - ArchWiki]

**Debian** :

- 6. [Debian 12 "bookworm" complete sources.list · GitHub]
- 7. [Hyprland on Debian 12](https://software.opensuse.org/download.html?project=home%3ASunderland93%3Ahyprland-debian&package=hyprland)

**Ubuntu** :

- 8. [LLVM Debian/Ubuntu packages]

### Packages URL and References

- **anyrun-git**: No project found.
- **betterlockscreen**: [https://github.com/pavanjadhaw/betterlockscreen](https://github.com/pavanjadhaw/betterlockscreen)⁴.
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
- **libwlroots-dev**: [https://gitlab.freedesktop.org/xorg/lib/libxcb](https://gitlab.freedesktop.org/xorg/lib/libxcb).
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
- **nwg-shell**: [https://github.com/nwg-piotr/nwg-shell](https://github.com/nwg-piotr/nwg-shell).
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

- (1) Arch Linux - Package Search. https://archlinux.org/packages/.
- (2) Arch Linux · GitHub. https://github.com/orgs/archlinux/repositories.
- (3) arch-linux-packages · GitHub Topics · GitHub. https://github.com/topics/arch-linux-packages.
- (4) Arch Linux · GitHub. https://github.com/archlinux.
- (5) GitHub - archlinux/archinstall: Arch Linux installer - https://github.com/archlinux/archinstall.

### Troubleshooting

```bash
E: Impossible de trouver le paquet anyrun-git
E: Impossible de trouver le paquet anytype
E: Impossible de trouver le paquet archlinux-betterlockscreen
E: Impossible de trouver le paquet archlinux-logout
E: Impossible de trouver le paquet azote
E: Impossible de trouver le paquet blueberry
E: Impossible de trouver le paquet boost-libs
E: Impossible de trouver le paquet libqalculate
E: Impossible de trouver le paquet network-manager-applet
E: Impossible de trouver le paquet nlohmann-json
E: Impossible de trouver le paquet nwg-bar-bin
E: Impossible de trouver le paquet nwg-displays
E: Impossible de trouver le paquet nwg-dock-bin
E: Impossible de trouver le paquet nwg-dock-hyprland-bin
E: Impossible de trouver le paquet nwg-drawer-bin
E: Impossible de trouver le paquet nwg-look-bin
E: Impossible de trouver le paquet nwg-panel
E: Impossible de trouver le paquet python-build
E: Impossible de trouver le paquet python-desktop-entry-lib
E: Impossible de trouver le paquet python-pillow
E: Impossible de trouver le paquet python-poetry
E: Impossible de trouver le paquet python-pywal
E: Impossible de trouver le paquet starship
E: Impossible de trouver le paquet ttf-jetbrains-mono
E: Impossible de trouver le paquet xorg-xrandr
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
