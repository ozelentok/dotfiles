#!/bin/bash

# ========================================
# Base packages
sudo pacman -Syu
sudo pacman -S i3-wm i3lock i3status dmenu gvim feh ctags keepassx htop samba unrar zsh gimp audacity vlc smplayer deluge chromium ntfs-3g xorg-server xorg-xinit xorg-xkill exfat-utils fuse-exfat alsa-utils gnome-settings-daemon

# Modules
sudo ./modules/gnome/install.sh
sudo ./modules/X11/install.sh
sudo ./modules/git/install.sh
sudo ./modules/zsh/install.sh
sudo ./modules/i3/install.sh
sudo ./modules/vim/install.sh
sudo ./modules/samba/install.sh
