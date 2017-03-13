#!/bin/bash

echo ""
echo "========================================"
echo "Configuring neovim"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

#clang for Deoplete C/C++ Support
#xsel and xclip for Clipboard support 
sudo pacman -S neovim clang xsel xclip
sudo pip install neovim 
sudo pip2 install neovim

(
	cd $DIR
	ln -s ctags.conf $HOME/.ctags
	./gnu-global/install.sh

	mkdir -p $HOME/.config/nvim/dein/repos/github.com/Shougo/
	ln -s $DIR/init.vim $HOME/.config/nvim/init.vim
	git clone https://github.com/Shougo/dein.vim.git $HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim

	mkdir -p $HOME/.config/nvim/colors
	ln -s colosus.vim $HOME/.config/nvim/colors/colosus.vim

	mkdir -p $HOME/.config/nvim/plugin
	cp /usr/share/vim/vimfiles/plugin/gtags* $HOME/.config/nvim/plugin

	echo "Enter ':call dein#install()'" | nvim -
	echo ""
)
