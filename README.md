# Oz Elentok Dotfiles

- Linux Distribution: Arch Linux
- Date: 2017-05
- Window Manager: i3wm
- Program Launcher: dmenu
- Text Editor: Neovim
- Music Player: Rhythmbox
- Video Player: SMPlayer, VLC

## Installation

```
sudo pacman -S git
git clone https://github.com/ozelentok/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

## Set Up a Wallpaper

- Copy/Link an image to ~/Pictures/wallpaper.png

## Auto-mount partitions

- Run the following command to get the UUID of the partitions:
```
sudo blkid
```

- Open the file /etc/fstab with any text editor (root privileges are required)

- For each partition, add the following (single) line to the file:

```
UUID={uuid} /media/{mountname} {filesytem} rw,uid={username},gid=users,umask=003 0 0
```

Example:
```
UUID=0001111100001100 /media/data ntfs-3g rw,uid=bob,gid=users,umask=003 0 0
```
