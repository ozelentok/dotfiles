#!/bin/bash

# ========================================
# Base packages
sudo pacman -Syu
sudo pacman -S i3-wm i3lock i3status dmenu gvim feh ctags keepassx htop samba unrar zsh gimp audacity vlc smplayer deluge chromium ntfs-3g xorg-server xorg-xinit xorg-xkill exfat-utils fuse-exfat alsa-utils gnome-settings-daemon firefox

# Modules
./modules/gnome/install.sh
./modules/X11/install.sh
./modules/git/install.sh
./modules/zsh/install.sh
./modules/i3/install.sh
./modules/vim/install.sh
./modules/samba/install.sh
