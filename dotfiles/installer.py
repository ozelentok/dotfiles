import subprocess
import tempfile
from pathlib import Path
from . import utils


class Installer:

    @classmethod
    def base_packages(cls) -> None:
        utils.install_packages([
            'htop',
            'mlocate',
            'ripgrep',
            'unrar', 'p7zip', 'unzip',
            'rsync',
            'strace',
            'lsof',
            'man',
            'ntfs-3g',
            'exfat-utils', 'fuse-exfat',
            'udisks2',
            'inetutils',
            'net-tools',
            'bind-tools',
            'imagemagick',

            'python-pip',
            'nodejs', 'npm',
            'ctags',

            'pulseaudio', 'pulseaudio-alsa', 'pavucontrol', 'alsa-utils',
            'polkit', 'polkit-gnome',

            'firefox-developer-edition',
            'chromium',
            'keepassxc',
            'eog',
            'evince',
            'rdesktop',
            'audacity',
            'wireshark-qt',
            'libreoffice-fresh',
            'wine',
            'vlc',
        ])

    @classmethod
    def deluge(cls) -> None:
        utils.install_packages(['deluge', 'deluge-gtk', 'gtk3', 'python-gobject', 'python-cairo',
                               'librsvg', 'libappindicator-gtk3', 'libnotify'])

    @classmethod
    def doublecmd(cls):
        utils.install_packages(['doublecmd-gtk2'])
        config_dir_path = Path.home() / '.config/doublecmd'
        utils.mkdir(config_dir_path)
        utils.copy_dotfile(Path('doublecmd/doublecmd.xml'), config_dir_path)

    @classmethod
    def fontconfig(cls) -> None:
        utils.install_packages(['noto-fonts', 'noto-fonts-cjk', 'noto-fonts-emoji',
                                'ttf-hack-nerd', 'ttf-liberation', 'ttf-roboto', 'fontconfig'])

        config_dir_path = Path.home() / '.config/fontconfig'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('fontconfig/fonts.conf'), config_dir_path)

    @classmethod
    def gimp(cls) -> None:
        utils.install_packages(['gimp', 'xsane', 'xsane-gimp'])

    @classmethod
    def git(cls) -> None:
        utils.install_packages(['git'])
        utils.copy_dotfile(Path('git/gitconfig'), Path.home(), hidden=True)
        utils.symlink_dotfile(Path('git/gitignore_global'), Path.home(), hidden=True)

    @classmethod
    def gtk(cls) -> None:
        utils.install_packages(['gtk2', 'gtk3'])
        config_dir_path = Path.home() / '.config/gtk-3.0'
        utils.mkdir(config_dir_path)

        utils.run_shell_command('dconf load / < gtk/dconf.ini')
        utils.symlink_dotfile(Path('gtk/gtk-3.0-settings.ini'), config_dir_path / 'settings.ini')
        utils.symlink_dotfile(Path('gtk/gtkrc-2.0'), Path.home(), hidden=True)

    @classmethod
    @utils.avoid_reinstall('pikaur')
    def pikaur(cls) -> None:
        utils.install_packages(['base-devel', 'git'])
        with tempfile.TemporaryDirectory() as tmp_build_path:
            subprocess.check_call(['git', 'clone',
                                   'https://aur.archlinux.org/pikaur.git',
                                   tmp_build_path])
            subprocess.check_call(['makepkg', '-sci', '--needed', '--noconfirm'],
                                  cwd=tmp_build_path)

    @classmethod
    def i3(cls) -> None:
        utils.install_packages([
            'i3-wm', 'i3lock', 'py3status',
            'dmenu', 'feh', 'autocutsel',
            'dunst', 'scrot',
            'python-pytz', 'python-tzlocal', 'xorg-xset'
        ])

        config_dir_path = Path.home() / '.config/i3'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('i3/i3.config'), config_dir_path / 'config')
        utils.symlink_dotfile(Path('i3/i3-session'), config_dir_path)
        utils.symlink_dotfile(Path('i3/i3status.conf'), config_dir_path)
        utils.symlink_dotfile(Path('i3/py3status'), config_dir_path)

        cls.pikaur()
        utils.install_aur_packages(['alttab-git', 'xkb-switch'])

    @classmethod
    def picom(cls) -> None:
        utils.install_packages(['picom'])
        config_dir_path = Path.home() / '.config'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('picom/picom.conf'), config_dir_path)

    @classmethod
    def mount_utils(cls) -> None:
        utils.install_packages(['sshfs', 'cifs-utils', 'fuse3'])
        utils.run_shell_command('sudo mkdir -p /mnt/sftp /mnt/cifs')
        utils.run_shell_command('sudo chown $USER:users /mnt/sftp /mnt/cifs')
        user_bin_dir_path = Path.home() / '.local/bin'
        utils.mkdir(user_bin_dir_path)
        utils.symlink_dotfile(Path('mount-utils/wmount.sh'), user_bin_dir_path / 'wmount')
        utils.symlink_dotfile(Path('mount-utils/wumount.sh'), user_bin_dir_path / 'wumount')
        utils.symlink_dotfile(Path('mount-utils/sftpmount.sh'), user_bin_dir_path / 'sftpmount')
        utils.symlink_dotfile(Path('mount-utils/sftpumount.sh'), user_bin_dir_path / 'sftpumount')

    @classmethod
    def mpv(cls) -> None:
        utils.install_packages(['mpv'])
        config_dir_path = Path.home() / '.config/mpv'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('mpv/mpv.conf'), config_dir_path)

    @classmethod
    def neovim(cls) -> None:
        utils.install_packages([
            'neovim', 'python-neovim', 'words',
            'xsel', 'xclip',
            'nodejs', 'npm',
            'global', 'python-pygments',
            'tidy', 'python-isort',
            'pyright',
            'clang',
            'lua-language-server',
            'sqlfluff',
        ])
        utils.run_shell_command('sudo ln -s -f -r $(which nvim) /usr/local/bin/vim')

        packer_dir_path = Path.home() / '.local/share/nvim/site/pack/packer/start/packer.nvim'
        if not packer_dir_path.exists():
            subprocess.check_call(['git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer_dir_path])

        config_dir_path = Path.home() / '.config/nvim'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('neovim/init.lua'), config_dir_path)
        utils.symlink_dotfile(Path('neovim/lua'), config_dir_path)
        utils.symlink_dotfile(Path('neovim/globalrc'), Path.home(), hidden=True)
        utils.symlink_dotfile(Path('neovim/ctags.conf'), Path.home() / '.ctags')
        cls.upgrade_neovim_plugins()

    @classmethod
    def upgrade_neovim_plugins(cls):
        utils.run_shell_command('sudo npm install -g neovim eslint vscode-langservers-extracted')
        utils.run_shell_command('nvim -c "autocmd User PackerComplete quitall" -c "PackerSync"')
        utils.run_shell_command('nvim -c "TSUpdateSync" -c q')

    @classmethod
    def qtconfig(cls) -> None:
        cls.pikaur()
        utils.install_aur_packages(['qt5-styleplugins'])
        config_dir_path = Path.home() / '.config'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('qtconfig/Trolltech.conf'), config_dir_path)

    @classmethod
    def ranger(cls) -> None:
        utils.install_packages(['ranger', 'ueberzug'])
        config_dir_path = Path.home() / '.config/ranger'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('ranger/rc.conf'), config_dir_path)
        utils.run_shell_command('/usr/bin/ranger --copy-config=scope')

    @classmethod
    def samba(cls) -> None:
        utils.install_packages(['samba'])
        samba_user = input('Enter Samba Username: ')
        utils.run_shell_command('sudo mkdir -p /etc/samba')
        utils.symlink_dotfile_with_root(Path('samba/smb.conf'), Path('/etc/samba/smb.conf'))
        utils.run_shell_command(
            'sudo sh -c "sed -e \"s/HOST_NAME/$(hostname)/\" samba/machine.conf > /etc/samba/machine.conf"')

        utils.run_shell_command(f'sudo useradd {samba_user} -g users -s /bin/nologin')
        utils.run_shell_command(f'sudo smbpasswd -a {samba_user}')
        utils.run_shell_command(
            f'echo "{samba_user} = \"{samba_user}\"" | sudo tee -a /etc/samba/smbusers > /dev/null')
        utils.run_shell_command('sudo systemctl enable smb')

    @classmethod
    def upgrade_scripts_dependencies(cls) -> None:
        utils.run_shell_command('pip install --user -U -r scripts/requirements.txt')

    @classmethod
    def sensors(cls) -> None:
        utils.install_packages(['lm_sensors'])
        utils.run_shell_command('sudo sensors-detect')

    @classmethod
    def smplayer(cls) -> None:
        utils.install_packages(['smplayer'])
        config_dir_path = Path.home() / '.config/smplayer'
        utils.mkdir(config_dir_path)
        utils.copy_dotfile(Path('smplayer/smplayer.ini'), config_dir_path)

    @classmethod
    def theme(cls) -> None:
        themes_dir_path = Path.home() / '.themes'
        icons_dir_path = Path.home() / '.local/share/icons'
        utils.mkdir(themes_dir_path)
        utils.mkdir(icons_dir_path)
        utils.symlink_relative(icons_dir_path, Path.home() / '.icons')

        utils.extract_dotfile_tar(Path('theme/Flat-Remix-GTK-Blue-Darkest-20220627.tar.gz'), themes_dir_path)
        utils.extract_dotfile_tar(Path('theme/Arc-ICONS-1.5.7.tar.gz'), icons_dir_path)
        utils.extract_dotfile_tar(Path('theme/Future-Cyan-20230405.tar.gz'), icons_dir_path)

    @classmethod
    def tmux(cls) -> None:
        utils.install_packages(['tmux'])
        config_dir_path = Path.home() / '.config/tmux'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('tmux/tmux.conf'), config_dir_path)

    @classmethod
    def wezterm(cls) -> None:
        utils.install_packages(['wezterm'])
        config_dir_path = Path.home() / '.config/wezterm'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('wezterm/wezterm.lua'), config_dir_path)

    @classmethod
    def X11(cls) -> None:
        utils.install_packages(['xorg-server', 'xorg-xinit', 'xorg-xkill',
                                'xorg-xhost', 'xorg-xev'])
        config_dir_path = '/etc/X11/xorg.conf.d'
        utils.run_shell_command(f'sudo mkdir -p {config_dir_path}')
        utils.run_shell_command(f'sudo cp X11/00-keyboard.conf {config_dir_path}/')

        utils.symlink_dotfile(Path('X11/xinitrc'), Path.home(), hidden=True)
        utils.symlink_dotfile(Path('X11/Xresources'), Path.home(), hidden=True)

    @classmethod
    def zsh(cls) -> None:
        utils.install_packages(['zsh', 'zsh-completions', 'zsh-syntax-highlighting',
                                'fzf',
                                'lsd'])
        config_dir_path = Path.home() / '.zsh'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('zsh/zshrc'), Path.home(), hidden=True)
        utils.symlink_dotfile(Path('zsh/zprofile'), Path.home(), hidden=True)
        utils.run_shell_command('sudo usermod -s $(which zsh) ${USER}')

        lsd_config_dir_path = Path.home() / '.config/lsd'
        utils.mkdir(lsd_config_dir_path)
        utils.symlink_dotfile(Path('zsh/lsd-config.yaml'),
                              lsd_config_dir_path / 'config.yaml')

    @classmethod
    def all(cls) -> None:
        cls.base_packages()
        cls.deluge()
        cls.doublecmd()
        cls.fontconfig()
        cls.git()
        cls.gimp()
        cls.gtk()
        cls.pikaur()
        cls.i3()
        cls.picom()
        cls.mount_utils()
        cls.mpv()
        cls.neovim()
        cls.qtconfig()
        cls.ranger()
        cls.samba()
        cls.upgrade_scripts_dependencies()
        cls.sensors()
        cls.smplayer()
        cls.theme()
        cls.tmux()
        cls.wezterm()
        cls.X11()
        cls.zsh()

    @classmethod
    def upgrade(cls) -> None:
        utils.run_shell_command('pikaur -Syu')
        cls.upgrade_scripts_dependencies()
        cls.upgrade_neovim_plugins()
