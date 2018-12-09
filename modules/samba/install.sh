#!/bin/bash

echo ""
echo "========================================"
echo "Configuring Samba Server"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)
TODIR="/etc/samba"

sudo pacman -Syu --needed samba

echo "Enter Samba Username: "
read smb_user
(
	cd $DIR
	sudo mkdir -p $TODIR
	sudo ln -s -f $DIR/smb.conf $TODIR/smb.conf

	if [ ! -f $TODIR/machine.conf ]; then
		sudo sh -c "sed -e \"s/HOST_NAME/$(hostname)/\" machine.conf > $TODIR/machine.conf"
	fi

	sudo useradd $smb_user -g users -s /bin/nologin
	sudo smbpasswd -a $smb_user
	echo "$smb_user = \"$smb_user\"" | sudo tee -a /etc/samba/smbusers > /dev/null

	sudo systemctl enable smb nmb
)
