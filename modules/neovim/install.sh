#!/bin/bash

echo ""
echo "========================================"
echo "Installing neovim"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

# clang for Deoplete C/C++ Support
# xsel and xclip for Clipboard support
sudo pacman -Syu --needed neovim cmake clang xsel xclip
pip install --user -U --upgrade-strategy=eager jedi neovim mypy pycodestyle autopep8 yapf Pygments
pip2 install --user -U --upgrade-strategy=eager neovim
sudo npm install -g neovim typescript tern tslint

sudo ln -s -f -r $(which nvim) /usr/local/bin/vim
export PATH="$HOME/.local/bin:$PATH"

(
	cd $DIR
	mkdir -p $HOME/.config/nvim
	ln -s -f -r $DIR/init.vim $HOME/.config/nvim/init.vim

	mkdir -p $HOME/.config/nvim/dein/repos/github.com/Shougo/
	git clone https://github.com/Shougo/dein.vim.git $HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim

	mkdir -p $HOME/.config/nvim/colors
	ln -s -f -r $DIR/colosus.vim $HOME/.config/nvim/colors/
	ln -s -f -r $DIR/mypy.ini $HOME/.mypy.ini

	ln -s -f -r $DIR/ctags.conf $HOME/.ctags
	ln -s -f -r $DIR/globalrc $HOME/.globalrc

	mkdir -p $HOME/.config/nvim/plugin
	ln -s -f /usr/share/vim/vimfiles/plugin/gtags-cscope.vim $HOME/.config/nvim/plugin/
	ln -s -f /usr/share/vim/vimfiles/plugin/gtags.vim $HOME/.config/nvim/plugin/

	nvim -c "call dein#install()" -c "exit"
)
