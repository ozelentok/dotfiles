#!/bin/bash

set -e

if [ "$#" -lt 2 ]; then
	echo "sftpmount - Mount SFTP Share on /mnt/sftp"
	echo "Usage: sftpmount [HOST] [USER] [OPTIONS]"
	echo ""
	exit 1
fi
LOCAL_USER=$USER
LOCAL_GROUP=$(id -g -n $USER)
REMOTE_HOST=$1
REMOTE_USER=$2
mkdir -p /mnt/sftp/$REMOTE_HOST
set +e

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
