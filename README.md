# Oz Elentok Dotfiles

- Distribution: Arch Linux
- Desktop Environment: Sway + Waybar + SwayNotificationCenter
- Dark Theme for GTK and QT
- Program Launcher: wmenu
- Browser: Firefox
- File Manager: Double Commander / Yazi
- IDE / Text Editor: Neovim

## Installation

```bash
sudo pacman -Syu --needed python git
git clone --recursive https://github.com/ozelentok/dotfiles.git ~/.dotfiles && cd ~/.dotfiles
python -m dotfiles profile [PROFILE]

# Install Full profile
python -m dotfiles profile full

# Install Minimal profile
python -m dotfiles profile minimal

# Install ShellOnly profile
python -m dotfiles profile shellonly
```

## Upgrade
```bash
# Upgrade all packages relevant to current profile
python -m dotfiles upgrade
```

## Install specific package
```bash
# Install package with current profile settings
python -m dotfiles [PACKAGE_NAME]
```
