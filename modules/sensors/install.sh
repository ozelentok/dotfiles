#!/bin/bash

echo ""
echo "========================================"
echo "Configuring Temperatures Sensors"
echo "========================================"

sudo pacman -Syu --needed lm_sensors
(
	sudo sensors-detect
)
