import subprocess
import tempfile
from pathlib import Path

from . import utils


class Installer:

    def __init__(self, skip_upgrade=False):
        self._pm = utils.SystemPackageManager(skip_upgrade)

    def base_packages(self) -> None:
        self._pm.install_packages([
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

    def deluge(self) -> None:
        self._pm.install_packages([
            'deluge', 'deluge-gtk', 'gtk3', 'python-gobject', 'python-cairo', 'librsvg',
            'libappindicator-gtk3', 'libnotify'
        ])

    def doublecmd(self):
        self._pm.install_packages(['doublecmd-gtk2'])
        config_dir_path = Path.home() / '.config/doublecmd'
        utils.mkdir(config_dir_path)
        utils.copy_dotfile(Path('doublecmd/doublecmd.xml'), config_dir_path)

    def fontconfig(self) -> None:
        self._pm.install_packages([
            'noto-fonts', 'noto-fonts-cjk', 'noto-fonts-emoji', 'ttf-hack-nerd', 'ttf-liberation',
            'ttf-roboto', 'fontconfig'
        ])

        config_dir_path = Path.home() / '.config/fontconfig'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('fontconfig/fonts.conf'), config_dir_path)

    def gimp(self) -> None:
        self._pm.install_packages(['gimp', 'xsane', 'xsane-gimp'])

    def git(self) -> None:
        self._pm.install_packages(['git'])
        utils.copy_dotfile(Path('git/gitconfig'), Path.home(), hidden=True)
        utils.symlink_dotfile(Path('git/gitignore_global'), Path.home(), hidden=True)

    def gtk(self) -> None:
        self._pm.install_packages(['gtk2', 'gtk3'])
        config_dir_path = Path.home() / '.config/gtk-3.0'
        utils.mkdir(config_dir_path)

        utils.run_shell_command('dconf load / < gtk/dconf.ini')
        utils.symlink_dotfile(Path('gtk/gtk-3.0-settings.ini'), config_dir_path / 'settings.ini')
        utils.symlink_dotfile(Path('gtk/gtkrc-2.0'), Path.home(), hidden=True)

    @utils.avoid_reinstall('pikaur')
    def pikaur(self) -> None:
        self._pm.install_packages(['base-devel', 'git'])
        with tempfile.TemporaryDirectory() as tmp_build_path:
            subprocess.check_call(
                ['git', 'clone', 'https://aur.archlinux.org/pikaur.git', tmp_build_path])
            subprocess.check_call(['makepkg', '-sci', '--needed', '--noconfirm'],
                                  cwd=tmp_build_path)

    def i3(self) -> None:
        self._pm.install_packages([
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

        self.pikaur()
        self._pm.install_aur_packages(['alttab-git', 'xkb-switch'])

    def picom(self) -> None:
        self._pm.install_packages(['picom'])
        config_dir_path = Path.home() / '.config'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('picom/picom.conf'), config_dir_path)

    def mount_utils(self) -> None:
        self._pm.install_packages(['sshfs', 'cifs-utils', 'fuse3'])
        utils.run_shell_command('sudo mkdir -p /mnt/sftp /mnt/cifs')
        utils.run_shell_command('sudo chown $USER:users /mnt/sftp /mnt/cifs')
        user_bin_dir_path = Path.home() / '.local/bin'
        utils.mkdir(user_bin_dir_path)
        utils.symlink_dotfile(Path('mount-utils/wmount.sh'), user_bin_dir_path / 'wmount')
        utils.symlink_dotfile(Path('mount-utils/wumount.sh'), user_bin_dir_path / 'wumount')
        utils.symlink_dotfile(Path('mount-utils/sftpmount.sh'), user_bin_dir_path / 'sftpmount')
        utils.symlink_dotfile(Path('mount-utils/sftpumount.sh'), user_bin_dir_path / 'sftpumount')

    def mpv(self) -> None:
        self._pm.install_packages(['mpv'])
        config_dir_path = Path.home() / '.config/mpv'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('mpv/mpv.conf'), config_dir_path)

    def neovim(self) -> None:
        self._pm.install_packages([
            'neovim', 'python-neovim', 'words',
            'xsel', 'xclip',
            'nodejs', 'npm',
            'global', 'python-pygments',
            'yapf', 'tidy', 'python-isort',
            'pyright',
            'clang',
            'lua-language-server',
            'sqlfluff',
        ])
        utils.run_shell_command('sudo ln -s -f -r $(which nvim) /usr/local/bin/vim')

        packer_dir_path = Path.home() / '.local/share/nvim/site/pack/packer/start/packer.nvim'
        if not packer_dir_path.exists():
            subprocess.check_call([
                'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
                packer_dir_path
            ])

        config_dir_path = Path.home() / '.config/nvim'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('neovim/init.lua'), config_dir_path)
        utils.symlink_dotfile(Path('neovim/lua'), config_dir_path)
        utils.symlink_dotfile(Path('neovim/globalrc'), Path.home(), hidden=True)
        utils.symlink_dotfile(Path('neovim/ctags.conf'), Path.home() / '.ctags')
        self.upgrade_neovim_plugins()

    def upgrade_neovim_plugins(self):
        utils.run_shell_command('sudo npm install -g neovim eslint vscode-langservers-extracted')
        utils.run_shell_command('nvim -c "autocmd User PackerComplete quitall" -c "PackerSync"')
        utils.run_shell_command('nvim -c "TSUpdateSync" -c q')

    def qtconfig(self) -> None:
        self.pikaur()
        self._pm.install_aur_packages(['qt5-styleplugins'])
        config_dir_path = Path.home() / '.config'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('qtconfig/Trolltech.conf'), config_dir_path)

    def ranger(self) -> None:
        self._pm.install_packages(['ranger', 'ffmpegthumbnailer'])
        self.ueberzugpp()
        config_dir_path = Path.home() / '.config/ranger'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('ranger/rc.conf'), config_dir_path)
        utils.symlink_dotfile(Path('ranger/scope.sh'), config_dir_path)

    def ueberzugpp(self) -> None:
        self.pikaur()
        self._pm.install_aur_packages(['ueberzugpp'])
        config_dir_path = Path.home() / '.config/ueberzugpp'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('ueberzugpp/config.json'), config_dir_path)

    def samba(self) -> None:
        self._pm.install_packages(['samba'])
        samba_user = input('Enter Samba Username: ')
        utils.run_shell_command('sudo mkdir -p /etc/samba')
        utils.symlink_dotfile_with_root(Path('samba/smb.conf'), Path('/etc/samba/smb.conf'))
        utils.run_shell_command(
            'sudo sh -c "sed -e \"s/HOST_NAME/$(hostname)/\" samba/machine.conf > /etc/samba/machine.conf"'
        )

        utils.run_shell_command(f'sudo useradd {samba_user} -g users -s /bin/nologin')
        utils.run_shell_command(f'sudo smbpasswd -a {samba_user}')
        utils.run_shell_command(
            f'echo "{samba_user} = \"{samba_user}\"" | sudo tee -a /etc/samba/smbusers > /dev/null')
        utils.run_shell_command('sudo systemctl enable smb')

    def upgrade_scripts_dependencies(self) -> None:
        utils.run_shell_command('pip install --user -U -r scripts/requirements.txt')

    def sensors(self) -> None:
        self._pm.install_packages(['lm_sensors'])
        utils.run_shell_command('sudo sensors-detect')

    def smplayer(self) -> None:
        self._pm.install_packages(['smplayer'])
        config_dir_path = Path.home() / '.config/smplayer'
        utils.mkdir(config_dir_path)
        utils.copy_dotfile(Path('smplayer/smplayer.ini'), config_dir_path)

    def theme(self) -> None:
        themes_dir_path = Path.home() / '.themes'
        icons_dir_path = Path.home() / '.local/share/icons'
        utils.mkdir(themes_dir_path)
        utils.mkdir(icons_dir_path)
        utils.symlink_relative(icons_dir_path, Path.home() / '.icons')

        utils.extract_dotfile_tar(Path('theme/Flat-Remix-GTK-Blue-Darkest-20220627.tar.gz'),
                                  themes_dir_path)
        utils.extract_dotfile_tar(Path('theme/Arc-ICONS-1.5.7.tar.gz'), icons_dir_path)
        utils.extract_dotfile_tar(Path('theme/Future-Cyan-20230405.tar.gz'), icons_dir_path)

    def tmux(self) -> None:
        self._pm.install_packages(['tmux'])
        config_dir_path = Path.home() / '.config/tmux'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('tmux/tmux.conf'), config_dir_path)

    def vifm(self) -> None:
        self._pm.install_packages(['vifm'])
        config_dir_path = Path.home() / '.config/vifm'
        colors_dir_path = config_dir_path / 'colors'
        utils.mkdir(colors_dir_path)
        utils.symlink_dotfile(Path('vifm/vifmrc'), config_dir_path)
        utils.symlink_dotfile(Path('vifm/dircolors.vifm'), colors_dir_path)

    def wezterm(self) -> None:
        self._pm.install_packages(['wezterm'])
        config_dir_path = Path.home() / '.config/wezterm'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('wezterm/wezterm.lua'), config_dir_path)

    def X11(self) -> None:
        self._pm.install_packages(
            ['xorg-server', 'xorg-xinit', 'xorg-xkill', 'xorg-xhost', 'xorg-xev'])
        config_dir_path = '/etc/X11/xorg.conf.d'
        utils.run_shell_command(f'sudo mkdir -p {config_dir_path}')
        utils.run_shell_command(f'sudo cp X11/00-keyboard.conf {config_dir_path}/')

        utils.symlink_dotfile(Path('X11/xinitrc'), Path.home(), hidden=True)
        utils.symlink_dotfile(Path('X11/Xresources'), Path.home(), hidden=True)

    def zsh(self) -> None:
        self._pm.install_packages(
                ['zsh', 'zsh-completions', 'zsh-syntax-highlighting',
                 'fzf',
                 'lsd'])
        config_dir_path = Path.home() / '.zsh'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('zsh/zshrc'), Path.home(), hidden=True)
        utils.symlink_dotfile(Path('zsh/zprofile'), Path.home(), hidden=True)
        utils.run_shell_command('sudo usermod -s $(which zsh) ${USER}')

        lsd_config_dir_path = Path.home() / '.config/lsd'
        utils.mkdir(lsd_config_dir_path)
        utils.symlink_dotfile(Path('zsh/lsd-config.yaml'), lsd_config_dir_path / 'config.yaml')

    def all(self) -> None:
        self.base_packages()
        self.deluge()
        self.doublecmd()
        self.fontconfig()
        self.git()
        self.gimp()
        self.gtk()
        self.pikaur()
        self.i3()
        self.picom()
        self.mount_utils()
        self.mpv()
        self.neovim()
        self.qtconfig()
        self.ranger()
        self.samba()
        self.upgrade_scripts_dependencies()
        self.sensors()
        self.smplayer()
        self.theme()
        self.tmux()
        self.wezterm()
        self.X11()
        self.zsh()

    def upgrade(self) -> None:
        utils.run_shell_command('pikaur -Syu')
        self.upgrade_scripts_dependencies()
        self.upgrade_neovim_plugins()
