# Oz Elentok Dotfiles

- Distribution: Arch Linux
- Window Manager: i3wm + py3status
- Program Launcher: dmenu
- Browser: Firefox
- File Manager: Double Commander / Ranger
- IDE / Text Editor: Neovim

## Installation

```bash
sudo pacman -Syu python git
git clone --recursive https://github.com/ozelentok/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && python -m dotfiles
```

## Install specific package
```bash
cd ~/.dotfiles && python -m dotfiles [PACKAGE_NAME]
```
