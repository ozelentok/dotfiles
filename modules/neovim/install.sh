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
sudo pip install -U neovim mypy pycodestyle grip
sudo pip2 install -U neovim
sudo npm install -g neovim typescript tern
sudo ln -s $(which nvim) /usr/local/bin/vim

(
	cd $DIR
	ln -s $DIR/ctags.conf $HOME/.ctags
	./gnu-global/install.sh

	mkdir -p $HOME/.config/nvim/dein/repos/github.com/Shougo/
	ln -s $DIR/init.vim $HOME/.config/nvim/init.vim
	git clone https://github.com/Shougo/dein.vim.git $HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim

	mkdir -p $HOME/.config/nvim/colors
	ln -s $DIR/colosus.vim $HOME/.config/nvim/colors/colosus.vim
	ln -s $DIR/mypy.ini $HOME/.mypy.ini

	mkdir -p $HOME/.config/nvim/plugin
	cp /usr/share/vim/vimfiles/plugin/gtags* $HOME/.config/nvim/plugin

	nvim -c "call dein#install()" -c "exit"
)
