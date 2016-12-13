#!/bin/bash

echo ""
echo "========================================"
echo "Configuring neovim"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

sudo pacman -S neovim

#For Deoplete C/C++ Support
sudo pacman -S clang

(
	cd $DIR
	mkdir -p $HOME/.config/nvim/dein/repos/github.com/Shougo/
	ln -s $DIR/init.vim $HOME/config/nvim/init.vim
	git clone https://github.com/Shougo/dein.vim.git $HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim
	mkdir -p $HOME/.config/nvim/colors
	cp colosus.vim $HOME/.config/nvim/colors/colosus.vim
	echo "Enter ':call dein#install()'" | nvim -
)