#!/bin/bash
(
  cd ~
  sudo apt-get install -y git

  github_root="https://github.com/ozelentok"
  echo ""
  echo "========================================"
  echo "Cloning dotfiles"
  git clone $github_root/dotfiles $HOME/.dotfiles

  echo "========================================"
  echo "setting up linux"
  (
    cd $HOME/.dotfiles
    ./install.sh
  )
)
