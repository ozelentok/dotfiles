#!/bin/bash
set -e

# ========================================
# Base packages
sudo pacman -Syu ctags keepassx htop unrar gimp audacity vlc smplayer deluge chromium ntfs-3g exfat-utils fuse-exfat alsa-utils firefox liferea doublecommander-gtk2 net-tools openssh lm_sensors

# Modules
./modules/gnome/install.sh
./modules/X11/install.sh
./modules/git/install.sh
./modules/zsh/install.sh
./modules/i3/install.sh
./modules/vim/install.sh
./modules/samba/install.sh
./modules/vsftpd/install.sh
