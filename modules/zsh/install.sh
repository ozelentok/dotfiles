#!/bin/bash

#=========================================
# Zsh Settings Configuration
echo ""
echo "=============================="
echo "Zsh Settings Configuration"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -S zsh zsh-completions

(
	cd $DIR
	mkdir -p "$HOME/.zsh"
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh/syntaxhl
	git clone https://github.com/ozelentok/ZPrompt.git /tmp/ZPrompt

	echo "Zsh Settings Configuration"
	ln -s $PWD/zshrc $HOME/.zshrc
	cp $PWD/extra.zsh $HOME/.zsh/extra.zsh
	sudo usermod -s $(which zsh) $USER
	echo ""
	echo "=============================="
	echo "Installing ZPrompt for zsh"
	(
		cd /tmp/ZPrompt
		make TARGET_SHELL=zsh
		make install
		echo "=============================="
		echo "Installing patched Ubuntu Mono Fonts for ZPrompt"
		echo "Font Family Name: Ubuntu Mono ZPower"
		mkdir -p $HOME/.fonts
		cp PatchedFonts/*.otf $HOME/.fonts/
		sudo -E fc-cache -vf
	)
)
