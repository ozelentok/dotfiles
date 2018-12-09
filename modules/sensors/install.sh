#!/bin/bash

echo ""
echo "========================================"
echo "Installing Temperatures Sensors"
echo "========================================"

sudo pacman -Syu --needed lm_sensors
(
	sudo sensors-detect
)
