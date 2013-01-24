#!/bin/bash

# =======================================
# Installation Flags for extra packages
gimpFlag="n"
audacityFlag="n"
virtBoxFlag="n"
lampFlag="n"

# =======================================
# Extra packages prompt
read -p "Do you want to install GIMP - Image Editor [Y/n]?" gimpFlag
read -p "Do you want to install Audacity - Audio Editor [Y/n]?" audacityFlag
read -p "Do you want to install VirtualBox - Virtualizion software [Y/n]?" virtBoxFlag
read -p "Do you want to Install LAMP - Web Server software [Y/n]?" lampFlag

# ========================================
# Base packages
sudo apt-get update
sudo apt-get install -y vim-gnome \
  ctags keepassx htop samba \
  libpam-smbpass unrar \
  network-manager-gnome \
  krusader vlc smplayer \
  deluge qt4-qtconfig kupfer

# Extra packaes(optional)

if [[ $gimpFlag == [Yy]* ]]; then
	echo ""
	echo "====================="
	echo "Installing Gimp"
	sudo apt-get install -y gimp
fi
if [[ $audacityFlag == [Yy]* ]]; then
	echo ""
	echo "====================="
	echo "Installing Audacity"
	sudo apt-get install -y audacity

fi
if [[ $virtBoxFlag == [Yy]* ]]; then
	echo ""
	echo "====================="
	echo "Installing VirtualBox"
	sudo apt-get install -y virtualbox
fi
if [[ $lampFlag == [Yy]* ]]; then
	echo ""
	echo "====================="
	echo "Installing LAMP"
	sudo apt-get install -y taskel
	sudo taskel install lamp-server
fi
# ========================================
# Modules
sudo ./modules/google.sh
./modules/i3/install.sh
cp ./modules/vim/.vimrc ~/.vimrc

#=========================================
# Configure bash tab-completion case insensitive
echo ""
echo "=============================="
echo "Enabling case-insensitve auto-completion"
echo "set completion-ignore-case on" | sudo tee -a /etc/inputrc
