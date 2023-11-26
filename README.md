# Git directory to backup and restore my wayland, sway , hyprland config

## Set scripts executables

```bash
cd git_config
sudo chmod +x+w message.sh sync_to_repo.sh sync_to_system.sh
```

## How to use

### Install

```bash
cd
git clone https://github.com/tombombadilom/hyprland.git git_config
cd git_config
./sync_to_system.sh
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
