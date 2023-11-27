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
- [nwg-bar-bin](^3^) : Ce paquet est un gestionnaire de barres pour Wayland. Son URL GitHub est [https://github.com/nwg/nwg-bar-bin](^5^).
- [nwg-displays](^3^) : Ce paquet est un gestionnaire de moniteurs pour Wayland. Son URL GitHub est [https://github.com/nwg/nwg-displays].
- [nwg-dock-bin](^3^) : Ce paquet est un gestionnaire de dockets pour Wayland. Son URL GitHub est [https://github.com/nwg/nwg-dock-bin].
- [nwg-dock-hyprland-bin](^3^) : Ce paquet est un gestionnaire de dockets pour Wayland avec le support du dock Hyprland. Son URL GitHub est [https://github.com/nwg/nwg-dock-hyprland-bin].
- [nwg-drawer-bin](^3^) : Ce paquet est un gestionnaire de panneaux pour Wayland. Son URL GitHub est [https://github.com/nwg/nwg-drawer-bin].
- [nwg-look-bin](^3^) : Ce paquet est un gestionnaire d'apparence pour Wayland. Son URL GitHub est [https://github.com/nwg/nwg-look-bin](^{10}).
- [nwg-panel](^[3]^) : Ce paquet est un gestionnaire de panneaux pour Wayland. Son URL GitHub est [https://github.com/nwg/nwg-panel](^[11]^).
- [pamac](^[3]^) : Ce paquet est une interface graphique pour pacman et archlinux mirror. Son URL GitHub est [https://github.com/pamac/pamac](^[12]^).
- [paru-bin](^[3]^) : Ce paquet est une interface graphique pour paru, le gestionnaire de cache et de mirror d'Arch Linux. Son URL GitHub est [https://github.com/paru/paru-bin](^[13]^).
- [plank](^[3]^) : Ce paquet est une interface graphique pour plank, le gestionnaire de bureau d'Arch Linux. Son URL GitHub est [https://github.com/plank-app/plank-desktop-apps)]^.
  Je suis désolé pour la confusion. Voici les URL GitHub des projets correspondant à votre liste de paquets Arch Linux :

- [playerctl](^3^) : Un outil en ligne de commande pour contrôler les lecteurs multimédias sous Linux. Son URL GitHub est [https://github.com/altdesktop/playerctl].
- [polybar](^3^) : Une barre de statut rapide et facile à utiliser pour les fenêtres X11. Son URL GitHub est [https://github.com/polybar/polybar].
- [procps](^3^) : Un ensemble d'outils pour surveiller les processus système. Son URL GitHub est [https://github.com/procps-ng/procps].
- [python-build](^3^) : Un script pour construire différentes versions de Python. Son URL GitHub est [https://github.com/pyenv/pyenv/tree/master/plugins/python-build].
- [python-desktop-entry-lib](^3^) : Une bibliothèque Python pour manipuler les fichiers de bureau. Son URL GitHub est [https://github.com/smothers/python-desktop-entry].
- [python-pillow](^3^) : Une bibliothèque de traitement d'images pour Python. Son URL GitHub est [https://github.com/python-pillow/Pillow].
- [python-poetry](^3^) : Un outil pour gérer les dépendances et les environnements virtuels Python. Son URL GitHub est [https://github.com/python-poetry/poetry].
- [python-pywal](^3^) : Un outil pour générer des palettes de couleurs à partir d'images. Son URL GitHub est [https://github.com/dylanaraps/pywal].
- [qmplay2](^3^) : Un lecteur multimédia pour Linux. Son URL GitHub est [https://github.com/zaps166/QMPlay2].
- [ripgrep](^3^) : Un outil de recherche de chaînes de caractères rapide et facile à utiliser. Son URL GitHub est [https://github.com/BurntSushi/ripgrep].
- [rofi](^3^) : Un sélecteur de fenêtres, lanceur d'applications et bien plus encore pour X11. Son URL GitHub est [https://github.com/davatorium/rofi].
- [slurp](^3^) : Un outil pour sélectionner une région de l'écran et récupérer les coordonnées. Son URL GitHub est [https://github.com/emersion/slurp].
- [socat](^3^) : Un outil pour établir des connexions de données bidirectionnelles entre deux points. Son URL GitHub est [https://github.com/craSH/socat].
- [sox](^3^) : Un outil pour manipuler les fichiers audio. Son URL GitHub est [https://github.com/chirlu/sox].
- [starship](^3^) : Un prompt de shell rapide, personnalisable et minimaliste. Son URL GitHub est [https://github.com/starship/starship].
- [sway](^3^) : Un gestionnaire de fenêtres Wayland compatible avec i3. Son URL GitHub est [https://github.com/swaywm/sway].
- [swaybg](^3^) : Un outil pour définir des fonds d'écran pour Wayland. Son URL GitHub est [https://github.com/swaywm/swaybg].
- [swayidle](^3^) : Un outil pour gérer l'inactivité de l'utilisateur sous Wayland. Son URL GitHub est [https://github.com/swaywm/swayidle].
- [swaync](^3^) : Un outil pour gérer les notifications sous Wayland. Son URL GitHub est [https://github.com/swaywm/swaynag].
- [tint2](^3^) : Une barre de tâches légère pour X11. Son URL GitHub est [https://github.com/tint2/tint2].
- [ttf-jetbrains-mono](^3^) : Une police de caractères monospace pour les développeurs. Son URL GitHub est [https://github.com/JetBrains/JetBrainsMono].
- [ttf-material-symbols](^3^) : Une police de

Source : conversation avec Bing, 27/11/2023
(1) Arch Linux - Package Search. https://archlinux.org/packages/.
(2) Arch Linux - Package Search. https://archlinux.org/packages/.
(3) Arch Linux - Package Search. https://archlinux.org/packages/.
(4) Arch Linux - Package Search. https://archlinux.org/packages/.
(5) Arch Linux - Package Search. https://archlinux.org/packages/.
(6) Arch Linux - Package Search. https://archlinux.org/packages/.
(7) Arch Linux - Package Search. https://archlinux.org/packages/.
(8) Arch Linux - Package Search. https://archlinux.org/packages/.
(9) Arch Linux - Package Search. https://archlinux.org/packages/.
(10) Arch Linux - Package Search. https://archlinux.org/packages/.
(11) Arch Linux - Package Search. https://archlinux.org/packages/.
(12) Arch Linux - Package Search. https://archlinux.org/packages/.
(13) Arch Linux - Package Search. https://archlinux.org/packages/.
(14) Arch Linux - Package Search. https://archlinux.org/packages/.
(15) Arch Linux - Package Search. https://archlinux.org/packages/.
(16) Arch Linux - Package Search. https://archlinux.org/packages/.
(17) Arch Linux - Package Search. https://archlinux.org/packages/.
(18) Arch Linux - Package Search. https://archlinux.org/packages/.
(19) Arch Linux - Package Search. https://archlinux.org/packages/.
(20) Arch Linux - Package Search. https://archlinux.org/packages/.
(21) Arch Linux - Package Search. https://archlinux.org/packages/.
(22) Arch Linux - Package Search. https://archlinux.org/packages/.
(23) arch-linux-packages · GitHub Topics · GitHub. https://github.com/topics/arch-linux-packages.
(24) Arch Linux · GitHub. https://github.com/orgs/archlinux/repositories?type=all.
(25) GitHub - fwcd/arch-pkgs: List of useful Arch Linux packages. https://github.com/fwcd/arch-pkgs.
(26) Installing packages from Arch User Repsitory(AUR) · GitHub. https://gist.github.com/iamcaleberic/4d8bfa60902029426f0de2d786a8e6d6.
(27) Arch Linux - github-cli 2.39.1-1 (x86_64). https://archlinux.org/packages/extra/x86_64/github-cli/.
(28) Arch Linux · GitHub. https://github.com/orgs/archlinux/repositories.
(29) undefined. https://aur.archlinux.org/package_name.git.

J'espère que cette réponse vous satisfait. Si vous avez besoin d'autre chose, n'hésitez pas à me le demander 😊

Source : conversation avec Bing, 27/11/2023
(1) Arch Linux - github-cli 2.39.1-1 (x86_64). https://archlinux.org/packages/extra/x86_64/github-cli/.
(2) undefined. https://aur.archlinux.org/package_name.git.
(3) Arch Linux - github-cli 2.39.1-1 (x86_64). https://archlinux.org/packages/extra/x86_64/github-cli/.
(4) Arch Linux - github-cli 2.39.1-1 (x86_64). https://archlinux.org/packages/extra/x86_64/github-cli/.
(5) Arch Linux - github-cli 2.39.1-1 (x86_64). https://archlinux.org/packages/extra/x86_64/github-cli/.
(6) Arch Linux - github-cli 2.39.1-1 (x86_64). https://archlinux.org/packages/extra/x86_64/github-cli/.
(7) Arch Linux - github-cli 2.39.1-1 (x86_64). https://archlinux.org/packages/extra/x86_64/github-cli/.
(8) Arch Linux - Package Search. https://archlinux.org/packages/.
(9) Installing packages from Arch User Repsitory(AUR) · GitHub. https://gist.github.com/iamcaleberic/4d8bfa60902029426f0de2d786a8e6d6.
(10) Arch Linux · GitHub. https://github.com/orgs/archlinux/repositories.

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
