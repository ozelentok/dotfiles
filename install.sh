#!/bin/bash
set -e

# ========================================
# Temporary files for dialog
SELECTED_PACKAGES_FILE_PATH="/tmp/dotfiles_selected_packages"
SELECTED_MODULES_FILE_PATH="/tmp/dotfiles_selected_modules"

# ========================================
# Install dialog for TUI choice list
sudo pacman -Syu --needed dialog

dotfiles_packages=(
	firefox-developer-edition chromium
	openssh htop ranger mlocate ripgrep 
	unrar p7zip unzip rsync strace lsof man
	ntfs-3g exfat-utils fuse-exfat udisks2
	inetutils net-tools bind-tools wireshark-qt
	pulseaudio pulseaudio-alsa pavucontrol alsa-utils
	python python2 python-pip python2-pip
	nodejs npm ctags
	noto-fonts noto-fonts-emoji ttf-dejavu ttf-ubuntu-font-family
	vlc smplayer rdesktop libreoffice-fresh
	gimp audacity deluge
	wine)
dotfiles_modules=$(ls ./modules)

# ========================================
# Generating dialog arguments
packages_dialog_command_choices=""
for package in ${dotfiles_packages[@]}; do
	packages_dialog_command_choices="$packages_dialog_command_choices $package $package on "
done
modules_dialog_command_choices=""
for module in ${dotfiles_modules[@]}; do
	modules_dialog_command_choices="$modules_dialog_command_choices $module $module on "
done

# ========================================
# Asking user what to install
dialog --checklist "Packages to install" 40 75 35 $packages_dialog_command_choices 2> $SELECTED_PACKAGES_FILE_PATH
selected_packages=$(cat $SELECTED_PACKAGES_FILE_PATH)

dialog --checklist "Modules to install" 40 75 35 $modules_dialog_command_choices 2> $SELECTED_MODULES_FILE_PATH
selected_modules=$(cat $SELECTED_MODULES_FILE_PATH)

# ========================================
# Installing selected packages
sudo pacman -Syu --needed $selected_packages

# ========================================
# Installing selected modules
for module in $selected_modules; do
	./modules/$module/install.sh
done
