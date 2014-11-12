#!/bin/bash

#=========================================
# Zsh Settings Configuration
echo ""
echo "=============================="
echo "Zsh Settings Configuration"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)
(
	cd $DIR
	mkdir -p "$HOME/.zsh"
	git clone git://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh/syntaxhl

	echo "Zsh Settings Configuration"
	ln -s $PWD/zshrc $HOME/.zshrc
	ln -s $PWD/aliases.zsh $HOME/.zsh/aliases.zsh
	usermod -s $(which zsh) $USER
	echo ""
	echo "=============================="
	pwd
	echo "Installing Zsh Prompt: zspower"
	(
		cd Prompt
		make
		ln -s $PWD/zspower $HOME/.zsh/zspower
	)
	echo ""
	echo "=============================="
	echo "Installing patched Ubuntu Mono Fonts"
	echo "Font Family Name: Ubuntu Mono ZPower"
	mkdir -p $HOME/.fonts
	cp PatchedFonts/*.otf $HOME/.fonts/
	sudo -E fc-cache -vf
)
