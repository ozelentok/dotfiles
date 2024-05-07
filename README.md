# Oz Elentok Dotfiles

- Distribution: Arch Linux
- Window Manager: i3wm + py3status
- Program Launcher: dmenu
- Browser: Firefox
- File Manager: Double Commander / Ranger
- IDE / Text Editor: Neovim

## Installation

```bash
sudo pacman -Syu --needed python git
git clone --recursive https://github.com/ozelentok/dotfiles.git ~/.dotfiles && cd ~/.dotfiles
python -m dotfiles profile [PROFILE]

# Install Full profile
python -m dotfiles profile Full

# Install Minimal profile
python -m dotfiles profile Minimal

# Install ShellOnly profile
python -m dotfiles profile ShellOnly
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
