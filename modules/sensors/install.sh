#!/bin/bash

echo ""
echo "========================================"
echo "Configuring Temperatures Sensors"
echo "========================================"

sudo pacman -S lm_sensors
(
	sudo sensors-detect
)
