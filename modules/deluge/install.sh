#!/bin/bash

echo ""
echo "========================================"
echo "Installing Deluge"
echo "========================================"

sudo pacman -Syu --needed deluge deluge-gtk gtk3 python-gobject python-cairo librsvg libappindicator-gtk3 libnotify 
