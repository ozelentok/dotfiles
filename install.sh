#!/bin/bash
#
# ========================================
# Base packages
sudo apt-get update
sudo apt-get install -y vim-gnome \
  ctags keepass2 htop samba \
  libpam-smbpass pysdm unrar \
  network-manager-gnome \
  krusader vlc smplayr \
	deluge gimp qt4-config

# ========================================
# Modules
sudo ./modules/google.sh
./modules/i3/install.sh

#=========================================
# Configure bash tab-completion case insensitive
echo "set completion-ignore-case on" | sudo tee -a /etc/inputrc
