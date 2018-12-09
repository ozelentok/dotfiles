#!/bin/bash

set -e

if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
	echo "sftpumount - Unmount SFTP Share from /mnt/sftp"
	echo "Usage: sftpumount host local_dir_name"
	echo ""
	exit 1
fi
REMOTE_HOST=$1
DIR=$2
fusermount -u /mnt/sftp/$REMOTE_HOST/$DIR
rmdir /mnt/sftp/$REMOTE_HOST/$DIR
rmdir --ignore-fail-on-non-empty /mnt/sftp/$REMOTE_HOST
echo "Share dismounted from /mnt/sftp/$REMOTE_HOST/$DIR"
