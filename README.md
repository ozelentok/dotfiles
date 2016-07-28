#Oz Elentok Dotfiles

- Linux Distribution: Arch Linux
- Date: 2016-07
- Window Manager: i3wm
- Program Launcher: dmenu
- Text Editor: Vim
- Music Player: Rhythmbox
- Video Player: SMPlayer, VLC
- RSS Reader: Lifera

##Installation

1. Install git
```
sudo pacman -S
```

2. Clone dotfiles
```
git clone https://github.com/ozelentok/dotfiles.git ~/.dotfiles
```

3. Run the installer
```
cd ~/.dotfiles
./install.sh
```

##Set Up a Wallpaper

- Copy/Link the image to ~/Pictures/wallpaper.png

##Qt-Config

Programs which use Qt will look horrible unless configured with qtconfig

1. Run qtconfig and the window 'Qt Configuration' will appear
```
qtconfig-qt4
```

2. Under the 'Appearance' tab, at GUI Style, select 'GTK+'

##View CPU Temperatures

1. Configure the sensors (follow the prompt instructions)
```
sudo sensors-detect
```

2. To view your CPU temperatures, run the following command
```
sensors
```

##Auto-mount partitions

1. Run the following command to get the UUID of the partitions:
```
sudo blkid
```

2. Open the file /etc/fstab with any text editor (root privileges are required)

3. For each partition, add the following (single) line to the file:

UUID={uuid} /media/{mountname} {filesytem} rw,uid={username},gid=users,umask=003 0 0

Notes:
{uuid} = The UUID of the partition
{mountname} = The name of the mount point
{filesystem} = The filesystem of the partiton

by setting the gid to "sambashare", the special samba user defined in the previous section can access shares on these partitions.

Example:
UUID=0001111100001100 /media/data ntfs-3g rw,uid=bob,gid=users,umask=003 0 0
