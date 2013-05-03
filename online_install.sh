#!/bin/bash
(
  cd ~
  sudo apt-get install -y git

#  github_root="git@github.com:ozelentok"
#  if [ "$(whoami)" != "oz" ]; then
    github_root="https://github.com/ozelentok"
#  fi

  echo ""
  echo "========================================"
  echo "Cloning dotfiles"
  git clone $github_root/dotfiles

  echo "========================================"
  echo "setting up linux"
  (
    cd dotfiles
    ./install.sh
  )
)
