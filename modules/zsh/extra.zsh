alias pwf='sudo poweroff'
alias rbt='sudo reboot'
alias mtp-mount='simple-mtpfs /mnt/mtp'
alias mtp-umount='fusermount -u /mnt/mtp'
#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

rdp() {
	rdesktop $1 -g 1600x900 -u $2 -z -m -x m -0
}
