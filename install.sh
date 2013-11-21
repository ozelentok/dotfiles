#!/bin/bash

# ========================================
# Base packages
sudo pacman -Sy
sudo pacman -S gvim feh ctags keepassx htop samba unrar zsh gimp audacity krusader vlc smplayer deluge chromium ntfs-3g xorg-xkill exfat-utils fuse-exfat

# Modules
./modules/X11/install.sh
./modules/git/install.sh
./modules/zsh/install.sh
./modules/i3/install.sh
./modules/vim/install.sh
./modules/krusader/install.sh
