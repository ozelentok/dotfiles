import getpass
import inspect
import subprocess
import tempfile
from os import environ
from pathlib import Path

from . import utils


class Installer:

    def __init__(self, skip_upgrade=False) -> None:
        self._pm = utils.SystemPackageManager(skip_upgrade)

    @classmethod
    def list_packages(cls) -> list[str]:
        return [
            m[0] for m in inspect.getmembers(cls, predicate=inspect.isfunction)
            if not m[0].startswith('_')
        ]

    @utils.avoid_reinstall('pikaur')
    def pikaur(self) -> None:
        self._pm.install_packages(['base-devel', 'git'])
        with tempfile.TemporaryDirectory() as tmp_build_path:
            subprocess.check_call(
                ['git', 'clone', 'https://aur.archlinux.org/pikaur.git', tmp_build_path])
            subprocess.check_call(['makepkg', '-sci', '--needed', '--noconfirm'],
                                  cwd=tmp_build_path)

    def base_packages(self) -> None:
        self._pm.install_packages([
            'htop',
            'mlocate',
            'fd',
            'ripgrep',
            'unrar', 'p7zip', 'unzip',
            'rsync',
            'strace',
            'lsof',
            'man',

            'inetutils',
            'net-tools',
            'bind-tools',

            'polkit',

            'ntfs-3g',
            'exfat-utils', 'fuse-exfat',
        ]) # yapf: disable

    def desktop_programs(self) -> None:
        self._pm.install_packages([
            'firefox-developer-edition',
            'chromium',
            'keepassxc',
            'evince',
            'rdesktop',
            'audacity',
            'wireshark-qt',
            'libreoffice-fresh',
            'wine',
            'vlc',
            'playerctl',
        ]) # yapf: disable

    def tmpfs_programs_cache(self) -> None:
        runtime_dir = Path(environ['XDG_RUNTIME_DIR'])
        runtime_cache = runtime_dir / 'cache'
        runtime_cache.mkdir(exist_ok=True)
        links = [
            Path.home() / '.cache/doublecmd',
            Path.home() / '.cache/gimp',
            Path.home() / '.cache/mozilla',
            Path.home() / '.cache/nvim',
            Path.home() / '.cache/thumbnails',
            Path.home() / '.cache/pikaur/build',
            Path.home() / '.mozilla/firefox/firefox-mpris',
            Path.home() / '.wine/drive_c/users' / getpass.getuser() / 'Temp'
        ]
        for l in links:
            c = runtime_cache / l.name
            # Cache dirs are also created at login by $HOME/.profile
            c.mkdir(exist_ok=True)
            utils.symlink(c, l)

    def media_processing(self) -> None:
        self._pm.install_packages([
            'perl-image-exiftool',
            'ffmpeg',
            'imagemagick',
            'pdftk',
            'easytag',
        ]) # yapf: disable

    def bluetooth(self) -> None:
        self._pm.install_packages([
            'pulseaudio-bluetooth', 'bluez',
            'blueman',
            'gst-plugins-bad', # For AptX suppport
            'chntpw', # For extraction of pairing keys from Windows
        ]) # yapf: disable

        utils.copy_dotfile_as_root(Path('bluetooth/main.conf'), Path('/etc/bluetooth'))
        utils.run_shell_command('sudo systemctl enable bluetooth')

    def deluge(self) -> None:
        self._pm.install_packages([
            'deluge', 'deluge-gtk', 'gtk3', 'python-gobject', 'python-cairo', 'librsvg',
            'libappindicator-gtk3', 'libnotify'
        ]) # yapf: disable

    def doublecmd(self):
        self._pm.install_packages(['doublecmd-gtk2'])
        config_dir_path = Path.home() / '.config/doublecmd'
        utils.mkdir(config_dir_path)
        utils.copy_dotfile(Path('doublecmd/doublecmd.xml'), config_dir_path)

    def fontconfig(self) -> None:
        self._pm.install_packages([
            'noto-fonts', 'noto-fonts-cjk', 'noto-fonts-emoji', 'ttf-hack-nerd', 'ttf-liberation',
            'ttf-roboto', 'fontconfig'
        ]) # yapf: disable

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
        self._pm.install_packages(['gtk2', 'gtk3', 'polkit-gnome'])
        config_dir_path = Path.home() / '.config/gtk-3.0'
        system_config_dir_path = Path('/etc/gtk-3.0')
        utils.mkdir(config_dir_path)
        utils.run_shell_command(f'sudo mkdir -p "{system_config_dir_path}"')

        utils.symlink_dotfile(Path('gtk/gtk-3.0-settings.ini'), config_dir_path / 'settings.ini')
        utils.copy_dotfile_as_root(Path('gtk/gtk-3.0-settings.ini'),
                                   system_config_dir_path / 'settings.ini')
        utils.symlink_dotfile(Path('gtk/gtkrc-2.0'), Path.home(), hidden=True)
        utils.run_shell_command('dconf load / < gtk/dconf.ini')

    def i3(self) -> None:
        self._pm.install_packages([
            'i3-wm', 'py3status',
            'dmenu', 'feh', 'autocutsel',
            'dunst', 'scrot',
            'meson', # For i3lock-git
            'python-pip', 'python-pytz', 'python-tzlocal', 'xorg-xset', 'xorg-xrandr'
        ]) # yapf: disable
        utils.run_shell_command('pip install --user --break-system-packages -U pulsectl')

        config_dir_path = Path.home() / '.config/i3'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('i3/i3.config'), config_dir_path / 'config')
        utils.symlink_dotfile(Path('i3/i3-session'), config_dir_path)
        utils.symlink_dotfile(Path('i3/i3status.conf'), config_dir_path)
        utils.symlink_dotfile(Path('i3/py3status'), config_dir_path)

        self.pikaur()
        self._pm.install_aur_packages(['i3lock-git', 'xkb-switch'])

    def lxdm(self) -> None:
        self._pm.install_packages(['lxdm-gtk3'])

        config_dir_path = Path('/etc/lxdm')
        themes_dir_path = Path('/usr/share/lxdm/themes')

        utils.copy_dotfile_as_root(Path('lxdm/lxdm.conf'), config_dir_path)
        utils.copy_dotfile_as_root(Path('lxdm/PostLogout'), config_dir_path)
        utils.extract_dotfile_tar_as_root(Path('theme/LXDM-Arch-Darkest.tar.gz'), themes_dir_path)

        self.pikaur()
        self._pm.install_aur_packages(['xinit-xsession', 'xkb-switch'])

        utils.run_shell_command('sudo systemctl enable lxdm')

    def picom(self) -> None:
        self._pm.install_packages(['picom'])
        config_dir_path = Path.home() / '.config'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('picom/picom.conf'), config_dir_path)

    def pulseaudio(self) -> None:
        self._pm.install_packages([
            'pulseaudio', 'pulseaudio-alsa',
            'pavucontrol', 'alsa-utils',
        ]) # yapf: disable

        config_dir_path = Path.home() / '.config/pulse'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('pulseaudio/daemon.conf'), config_dir_path)

    def mcomix(self) -> None:
        self.pikaur()
        self._pm.install_aur_packages(['mcomix'])

    def mount_utils(self) -> None:
        self._pm.install_packages(['sshfs', 'cifs-utils', 'fuse3'])
        utils.run_shell_command('sudo mkdir -p /mnt/sftp /mnt/cifs')
        utils.run_shell_command('sudo chown ${USER}:users /mnt/sftp /mnt/cifs')
        user_bin_dir_path = Path.home() / '.local/bin'
        utils.mkdir(user_bin_dir_path)
        utils.symlink_dotfile(Path('mount-utils/wmount.sh'), user_bin_dir_path / 'wmount')
        utils.symlink_dotfile(Path('mount-utils/wumount.sh'), user_bin_dir_path / 'wumount')
        utils.symlink_dotfile(Path('mount-utils/sftpmount.sh'), user_bin_dir_path / 'sftpmount')
        utils.symlink_dotfile(Path('mount-utils/sftpumount.sh'), user_bin_dir_path / 'sftpumount')

    def mimeapps(self) -> None:
        config_dir_path = Path.home() / '.config'
        utils.symlink_dotfile(Path('mimeapps/mimeapps.list'), config_dir_path)

    def mpv(self) -> None:
        self._pm.install_packages(['mpv'])
        config_dir_path = Path.home() / '.config/mpv'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('mpv/mpv.conf'), config_dir_path)

    def neovim(self, developer: bool = True, x11: bool = True) -> None:
        self._pm.install_packages([
                'neovim',
                'python-neovim',
                'words',
                'gcc' # For TreeSitter
            ] + [
                'global', 'python-pip', 'python-pygments',
                'ctags',
                'yapf', 'tidy', 'python-isort',
                'pyright',
                'clang',
                'rust',
                'nodejs', 'npm',
                'eslint',
                'lua-language-server',
                'bash-language-server',
                'arduino-language-server',
                'yamllint',
                'sqlfluff'
            ] if developer else [] + [
                'xsel'
            ] if x11 else []
        ) # yapf: disable

        utils.run_shell_command('sudo ln -s -f -r $(which nvim) /usr/local/bin/vim')

        config_dir_path = Path.home() / '.config/nvim'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('neovim/init.lua'), config_dir_path)
        utils.symlink_dotfile(Path('neovim/lua'), config_dir_path)
        utils.symlink_dotfile(Path('neovim/after'), config_dir_path)

        if developer:
            self.nodejs()
            utils.symlink_dotfile(Path('neovim/globalrc'), Path.home(), hidden=True)
            utils.symlink_dotfile(Path('neovim/ctags.conf'), Path.home() / '.ctags')
            utils.symlink_dotfile(Path('neovim/settings_developer.lua'),
                                  config_dir_path / 'dotfiles_settings.lua')
        else:
            utils.symlink_dotfile(Path('neovim/settings_minimal.lua'),
                                  config_dir_path / 'dotfiles_settings.lua')

        self.neovim_plugins(developer, True)

    def neovim_plugins(self, developer: bool = True, installation: bool = False) -> None:
        if developer:
            utils.run_shell_command(
                'pip install --user --break-system-packages -U cmakelang cmake-language-server')
            utils.run_shell_command('cargo install openscad-lsp')
            utils.run_shell_command('npm install -g neovim vscode-langservers-extracted')

        try:
            if installation:
                utils.run_shell_command('nvim --headless "+Lazy! sync" "+qa"')
            else:
                utils.run_shell_command('nvim --headless "+Lazy! sync" "+TSUpdateSync" "+qa"')
        except KeyboardInterrupt:
            pass

    def nodejs(self) -> None:
        self._pm.install_packages(['nodejs', 'npm'])
        utils.symlink_dotfile(Path('nodejs/npmrc'), Path.home(), hidden=True)

    def qtconfig(self) -> None:
        self.pikaur()
        self._pm.install_aur_packages(['qt5-styleplugins'])
        config_dir_path = Path.home() / '.config'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('qtconfig/Trolltech.conf'), config_dir_path)

    def ranger(self, media_preview: bool = True) -> None:
        self._pm.install_packages(['ranger'] + ['ffmpegthumbnailer'] if media_preview else [])
        if media_preview:
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

    def scripts_dependencies(self) -> None:
        self._pm.install_packages(['python-pip'])
        utils.run_shell_command(
            'pip install --user --break-system-packages -U -r scripts/requirements.txt')

    def vmic(self) -> None:
        self._pm.install_packages(['python-pip'])
        utils.run_shell_command('pip install --user --break-system-packages -U pulsectl')

        bin_dir_path = Path.home() / '.local/bin'
        utils.mkdir(bin_dir_path)
        utils.symlink_dotfile(Path('pulseaudio/vmic'), bin_dir_path)

    def yt_dlp(self) -> None:
        self._pm.install_packages(['python-pip'])
        utils.run_shell_command('pip install --user --break-system-packages -U yt_dlp')

    def sensors(self) -> None:
        self._pm.install_packages(['lm_sensors'])
        utils.run_shell_command('sudo sensors-detect')

    def smplayer(self) -> None:
        self._pm.install_packages(['smplayer'])
        config_dir_path = Path.home() / '.config/smplayer'
        utils.mkdir(config_dir_path)
        utils.copy_dotfile(Path('smplayer/smplayer.ini'), config_dir_path)

    def theme(self) -> None:
        themes_dir_path = Path('/usr/share/themes/')
        icons_dir_path = Path('/usr/share/icons')
        utils.run_shell_command(f'sudo mkdir -p {themes_dir_path}')
        utils.run_shell_command(f'sudo mkdir -p {icons_dir_path}')

        utils.extract_dotfile_tar_as_root(Path('theme/Flat-Remix-GTK-Blue-Darkest-20220627.tar.gz'),
                                          themes_dir_path)
        utils.extract_dotfile_tar_as_root(Path('theme/Arc-ICONS-1.5.7.tar.gz'), icons_dir_path)
        utils.extract_dotfile_tar_as_root(Path('theme/Future-Cyan-20230405.tar.gz'), icons_dir_path)

    def tmux(self) -> None:
        self._pm.install_packages(['tmux'])
        config_dir_path = Path.home() / '.config/tmux'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('tmux/tmux.conf'), config_dir_path)

    def vifm(self) -> None:
        self._pm.install_packages(['vifm', 'python-pygments'])
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
        self._pm.install_packages([
            'xorg-server', 'xorg-xinit', 'xorg-xkill', 'xorg-xhost', 'xorg-xev',
            'xdg-utils', 'perl-file-mimeinfo'
        ]) # yapf: disable

        config_dir_path = '/etc/X11/xorg.conf.d'
        utils.run_shell_command(f'sudo mkdir -p {config_dir_path}')
        utils.run_shell_command(f'sudo cp X11/00-keyboard.conf {config_dir_path}/')

        utils.symlink_dotfile(Path('X11/xinitrc'), Path.home(), hidden=True)
        utils.symlink_dotfile(Path('X11/Xresources'), Path.home(), hidden=True)

    def x11vnc(self) -> None:
        self._pm.install_packages(['x11vnc'])
        utils.run_shell_command('x11vnc -storepasswd')

    def xnviewmp(self) -> None:
        self.pikaur()
        self._pm.install_aur_packages(['xnviewmp'])

    def zsh(self, developer: bool = True) -> None:
        self._pm.install_packages([
            'zsh', 'zsh-completions', 'zsh-syntax-highlighting',
            'fzf',
            'lsd',
            'which'
        ]) # yapf: disable

        utils.symlink_dotfile(Path('zsh/zshrc'), Path.home(), hidden=True)
        utils.symlink_dotfile(Path('zsh/zprofile'), Path.home(), hidden=True)
        utils.symlink_dotfile(Path('zsh/profile'), Path.home(), hidden=True)
        if developer:
            utils.symlink_dotfile(Path('zsh/settings_developer'),
                                  Path.home() / '.zsh_dotfiles_settings')
        else:
            utils.symlink_dotfile(Path('zsh/settings_minimal'),
                                  Path.home() / '.zsh_dotfiles_settings')

        utils.run_shell_command('sudo usermod -s $(which zsh) ${USER}')

        lsd_config_dir_path = Path.home() / '.config/lsd'
        utils.mkdir(lsd_config_dir_path)
        utils.symlink_dotfile(Path('zsh/lsd-config.yaml'), lsd_config_dir_path / 'config.yaml')
