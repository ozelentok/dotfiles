#!/bin/bash
#
# ========================================
# Base packages
sudo apt-get update
sudo apt-get install -y vim-gnome \
  ctags keepass2 htop samba \
  libpam-smbpass pysdm unrar \
  network-manager-gnome \
  krusader vlc smplayer

# ========================================
# Modules
sudo ./modules/google.sh
./modules/i3/install.sh
