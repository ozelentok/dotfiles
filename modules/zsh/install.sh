#!/bin/bash

echo ""
echo "=============================="
echo "Installing ZSH"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -Syu --needed zsh zsh-completions lsd gcc make

(
	cd $DIR
	echo "Zsh Settings Configuration"
	mkdir -p "$HOME/.zsh"
	ln -s -f -r $DIR/zshrc $HOME/.zshrc
	ln -s -f -r $DIR/zprofile $HOME/.zprofile
	if [ ! -L $HOME/.zsh/syntaxhl ]; then
		ln -s -f -r $DIR/zsh-syntax-highlighting $HOME/.zsh/syntaxhl
	fi
	sudo usermod -s $(which zsh) $USER

	echo "=============================="
	echo "Installing ZPrompt for zsh"
	(
		cd $DIR/ZPrompt
		make TARGET_SHELL=zsh
		make install TARGET_SHELL=zsh
	)
)
