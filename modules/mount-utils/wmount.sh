#!/bin/bash

set -e

if [ "$#" -lt 3 ]; then
	echo "wmount - Mount CIFS Share on /mnt/cifs"
	echo "Usage: wmount [HOST] [SHARE] [USER] [OPTIONS]"
	echo ""
	exit 1
fi
LOCAL_USER=$USER
LOCAL_GROUP=$(id -g -n $USER)
REMOTE_HOST=$1
REMOTE_SHARE=$2
REMOTE_USER=$3
mkdir -p /mnt/cifs/$REMOTE_HOST/$REMOTE_SHARE
set +e
sudo mount -t cifs //$REMOTE_HOST/$REMOTE_SHARE \
/mnt/cifs/$REMOTE_HOST/$REMOTE_SHARE -o user=$REMOTE_USER,\
rw,uid=$LOCAL_USER,gid=$LOCAL_GROUP,cache=strict,${@:4}

MOUNT_EXIT_CODE=$?
set -e
if [ $MOUNT_EXIT_CODE -ne 0 ]; then
	rmdir /mnt/cifs/$REMOTE_HOST/$REMOTE_SHARE
	rmdir --ignore-fail-on-non-empty /mnt/cifs/$REMOTE_HOST
else
	echo "Share mounted on /mnt/cifs/$REMOTE_HOST/$REMOTE_SHARE"
fi
