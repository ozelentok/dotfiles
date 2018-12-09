#!/bin/bash

set -e

if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
	echo "wumount - Unmount CIFS Share from /mnt/cifs"
	echo "Usage: wumount host dir"
	echo ""
	exit 1
fi
REMOTE_HOST=$1
DIR=$2
sudo umount /mnt/cifs/$REMOTE_HOST/$DIR
rmdir /mnt/cifs/$REMOTE_HOST/$DIR
rmdir --ignore-fail-on-non-empty /mnt/cifs/$REMOTE_HOST
echo "Share dismounted from /mnt/cifs/$REMOTE_HOST/$DIR"
