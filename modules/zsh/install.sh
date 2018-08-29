#!/bin/bash

echo ""
echo "=============================="
echo "Configuring ZSH"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -S zsh zsh-completions gcc make

(
	cd $DIR
	echo "Zsh Settings Configuration"
	mkdir -p "$HOME/.zsh"
	ln -s -f $DIR/zshrc $HOME/.zshrc
	ln -s -f $DIR/zprofile $HOME/.zprofile
	ln -s -f $DIR/extra.zsh $HOME/.zsh/extra.zsh
	if [ ! -L $HOME/.zsh/syntaxhl ]; then
		ln -s -f $DIR/zsh-syntax-highlighting $HOME/.zsh/syntaxhl
	fi
	sudo usermod -s $(which zsh) $USER

	echo "=============================="
	echo "Installing ZPrompt for zsh"
	(
		cd $DIR/ZPrompt
		make TARGET_SHELL=zsh
		make install TARGET_SHELL=zsh
	)
	echo "=============================="
	echo "Installing patched Ubuntu Mono Fonts for ZPrompt"
	echo "Font Family Name: Ubuntu Mono ZPower"
	mkdir -p $HOME/.fonts
	cp $DIR/ZPrompt/PatchedFonts/*.otf $HOME/.fonts/
	fc-cache -vf
)
