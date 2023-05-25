#!/bin/bash

set -e

if [ "$#" -lt 2 ]; then
	echo "sftpmount - Mount SFTP Share on /mnt/sftp"
	echo "Usage: sftpmount [HOST] [USER] [OPTIONS]"
	echo ""
	exit 1
fi
REMOTE_HOST=$1
REMOTE_USER=$2
set +e

if [[ "$*" == *-u* ]]; then
	fusermount -u /mnt/sftp/$REMOTE_HOST
	rmdir /mnt/sftp/$REMOTE_HOST
	echo "Share dismounted from /mnt/sftp/$REMOTE_HOST"
	exit 0
fi

mkdir -p /mnt/sftp/$REMOTE_HOST
if [[ "${@:3}" != *directport* ]]; then
	sshfs $REMOTE_USER@$REMOTE_HOST:/ \
		/mnt/sftp/$REMOTE_HOST ${@:3}
else
	sshfs $REMOTE_HOST:/ \
		/mnt/sftp/$REMOTE_HOST ${@:3}
fi

MOUNT_EXIT_CODE=$?
set -e
if [ $MOUNT_EXIT_CODE -ne 0 ]; then
	rmdir /mnt/sftp/$REMOTE_HOST
else
	echo "Share mounted on /mnt/sftp/$REMOTE_HOST"
fi
