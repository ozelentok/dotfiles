#!/bin/bash

echo ""
echo "========================================"
echo "Configuring Samba"
echo "========================================"

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)
TODIR="/etc/samba"

sudo pacman -S samba

echo "Enter Samba Username: "
read smb_user
(
	cd $DIR
	sudo mkdir -p $TODIR
	sudo sh -c "sed -e \"s/HOST_NAME/$HOST/\" smb.conf > $TODIR/smb.conf"
	sudo cp $PWD/wmount.sh /usr/local/bin/wmount
	sudo cp $PWD/wumount.sh /usr/local/bin/wumount

	sudo useradd $smb_user -g users -s /bin/nologin
	sudo smbpasswd -a $smb_user
	echo "$smb_user = \"$smb_user\"" | sudo tee -a /etc/samba/smbusers > /dev/null
)
