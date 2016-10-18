#!/bin/bash
set -e

# ========================================
# Base packages
sudo pacman -Syu ctags keepassx htop unrar gimp audacity vlc smplayer deluge chromium ntfs-3g exfat-utils fuse-exfat alsa-utils firefox net-tools openssh

# Modules
./modules/gnome/install.sh
./modules/X11/install.sh
./modules/git/install.sh
./modules/zsh/install.sh
./modules/i3/install.sh
./modules/vim/install.sh
./modules/samba/install.sh
./modules/doublecmd/install.sh
./modules/vsftpd/install.sh
./modules/sensors/install.sh
