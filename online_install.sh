#!/bin/bash
(
  cd ~
	sudo pacman -Syu
  sudo pacman -S git
  github_root="https://github.com/ozelentok"
  echo ""
  echo "========================================"
  echo "Cloning dotfiles"
  git clone $github_root/dotfiles $HOME/.dotfiles
  echo "========================================"
  echo "setting up linux"
  (
    cd $HOME/.dotfiles
    sudo ./install.sh
  )
)
