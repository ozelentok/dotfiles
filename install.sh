#!/bin/bash

# ========================================
# Base packages
sudo pacman -Syu
sudo pacman -S i3-wm i3lock i3status dmenu gvim feh ctags keepassx htop samba unrar zsh gimp audacity vlc smplayer deluge chromium ntfs-3g xorg-server xorg-xinit xorg-xkill exfat-utils fuse-exfat alsa-utils gnome-settings-daemon firefox

# Modules
sudo -E ./modules/gnome/install.sh
sudo -E ./modules/X11/install.sh
sudo -E ./modules/git/install.sh
sudo -E ./modules/zsh/install.sh
sudo -E ./modules/i3/install.sh
sudo -E ./modules/vim/install.sh
sudo -E ./modules/samba/install.sh
