#!/bin/bash

#=========================================
# Zsh Settings Configuration
echo ""
echo "=============================="
echo "Zsh Settings Configuration"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

if [ ! -d "$HOME/.zsh" ]; then
	mkdir $HOME/.zsh
fi
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh/syntaxhl

echo "Zsh Settings Configuration"
ln -s $DIR/zshrc $HOME/.zshrc
ln -s $DIR/aliases.zsh $HOME/.zsh/aliases.zsh
ln -s $DIR/zspower.py $HOME/.zsh/zspower.py
sudo usermod -s $(which zsh) $USER
echo ""
echo "=============================="
echo "Installing patched Ubuntu Mono Fonts"
echo "Font Family Name: Ubuntu Mono ZPower"
mkdir -p $HOME/.fonts
cp $DIR/PatchedFonts/*.otf $HOME/.fonts/
fc-cache -vf
