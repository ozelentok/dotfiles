#!/bin/bash

echo ""
echo "========================================"
echo "Configuring Krusader"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

ln -sf "$DIR/krusaderrc" $HOME/.kde/share/config/krusaderrc
