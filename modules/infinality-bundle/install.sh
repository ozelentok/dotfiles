#!/bin/bash

echo ""
echo "=============================="
echo "Configuring Infinality-Bundle (Better Font Rendering)"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

(
	cd $DIR
	sudo bash -c "cat $DIR/pacman-infinality.conf >> /etc/pacman.conf"
	sudo pacman-key -r 962DDE58
	sudo pacman-key --lsign-key 962DDE58
	sudo pacman -Syu infinality-bundle infinality-bundle-multilib infinality-bundle-fonts
)
