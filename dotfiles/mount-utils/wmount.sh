#!/usr/bin/env bash

if [ "$#" -lt 3 ]; then
  echo "wmount - Mount CIFS Share on /mnt/cifs"
  echo "Usage: wmount [HOST] [SHARE] [USER] [-u] [OPTIONS]"
  echo ""
  exit 1
fi

REMOTE_HOST=$1
REMOTE_SHARE=$2
REMOTE_USER=$3

REMOTE_HOST_DIR="/mnt/cifs/$REMOTE_HOST"
MOUNTPOINT="$REMOTE_HOST_DIR/$REMOTE_SHARE"

if [[ "$4" == "-u" ]]; then
  if mountpoint -q "$MOUNTPOINT"; then
    # shellcheck disable=SC2068
    sudo umount "$MOUNTPOINT" ${@:5} || exit 1
  fi
  if [ -d "$MOUNTPOINT" ]; then
    rmdir "$MOUNTPOINT" || exit 1
  else
    echo "$MOUNTPOINT is not mounted"; exit 2
  fi

  rmdir --ignore-fail-on-non-empty "$REMOTE_HOST_DIR"
  exit 0
fi

LOCAL_USER=$USER
LOCAL_GROUP=$(id -g -n "$USER")

if mountpoint -q "$MOUNTPOINT"; then
  echo "$MOUNTPOINT is already mounted"; exit 1
fi

if ! mkdir -p "$MOUNTPOINT"; then
  echo "Failed to create directory $MOUNTPOINT"; exit 2
fi

# shellcheck disable=SC2068
sudo mount -t cifs "//$REMOTE_HOST/$REMOTE_SHARE" "$MOUNTPOINT" \
  -o "user=$REMOTE_USER,rw,uid=$LOCAL_USER,gid=$LOCAL_GROUP,cache=strict" ${@:4}

MOUNT_EXIT_CODE=$?
set -e
if [ $MOUNT_EXIT_CODE -ne 0 ]; then
  rmdir "$MOUNTPOINT"
  rmdir --ignore-fail-on-non-empty "$REMOTE_HOST_DIR"
else
  echo "Munted on $MOUNTPOINT"
fi
