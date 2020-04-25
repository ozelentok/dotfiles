# Oz Elentok Dotfiles

For Arch Linux
- Window Manager: i3wm
- Program Launcher: dmenu
- Browser: Firefox
- File Manager: Double Commander
- Text Editor: Neovim

## Installation

```
sudo pacman -S git
git clone --recursive https://github.com/ozelentok/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

## Set Up a Wallpaper

- Copy/Link an image to ~/Pictures/wallpaper.png

## Auto-mount partitions

- Run the following command to get the UUID of the partitions:
```bash
sudo blkid
```

- Open the file /etc/fstab with any text editor (root privileges are required)

- For each partition, add the following (single) line to the file:

```
UUID={uuid} /media/{mountname} {filesytem} rw,noatime,uid={username},gid=users,umask=003 0 0
```

Example:
```
UUID=0001111100001100 /media/data ntfs-3g rw,noatime,uid=bob,gid=users,umask=003 0 0
```
