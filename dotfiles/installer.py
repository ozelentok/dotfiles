import getpass
import inspect
import shutil
import subprocess
import tempfile
from os import environ
from pathlib import Path

from . import utils


class Installer:
    def __init__(self, skip_upgrade=False) -> None:
        self._pm = utils.SystemPackageManager(skip_upgrade)

    def install_aur_packages(self, packages: list[str]) -> None:
        self.pikaur()
        self._pm.install_aur_packages(packages)

    @classmethod
    def list_packages(cls) -> list[str]:
        return [
            m[0]
            for m in inspect.getmembers(cls, predicate=inspect.isfunction)
            if not m[0].startswith('_')
        ]

    @utils.avoid_reinstall('pikaur')
    def pikaur(self) -> None:
        self._pm.install_packages(['base-devel', 'git'])
        with tempfile.TemporaryDirectory() as tmp_build_path:
            subprocess.check_call(
                ['git', 'clone', 'https://aur.archlinux.org/pikaur.git', tmp_build_path]
            )
            subprocess.check_call(
                ['makepkg', '-sci', '--needed', '--noconfirm'], cwd=tmp_build_path
            )

    def base_packages(self) -> None:
        self._pm.install_packages([
            'htop',
            'plocate',
            'fd',
            'ripgrep',
            'unrar',
            '7zip',
            'unzip',
            'rsync',
            'strace',
            'lsof',
            'man',

            'inetutils',
            'net-tools',
            'bind',

            'polkit',

            'ntfs-3g',
            'exfat-utils', 'fuse-exfat',
        ])  # fmt: off

    def desktop_programs(self) -> None:
        self._pm.install_packages([
            'firefox',
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
        ])  # fmt: off

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
            Path.home() / '.cache/ueberzugpp',
            Path.home() / '.cache/pikaur/build',
            Path.home() / '.mozilla/firefox/firefox-mpris',
            Path.home() / '.wine/drive_c/users' / getpass.getuser() / 'Temp',
        ]
        for link_path in links:
            parent_path = link_path.parent
            utils.mkdir(parent_path)
            cache_path = runtime_cache / link_path.name
            # Cache dirs are also created at login by $HOME/.profile
            cache_path.mkdir(exist_ok=True)
            if link_path.exists() and not link_path.is_symlink():
                print(f'Deleting non-tmpfs linked cache directory: {link_path}')
                shutil.rmtree(link_path)
            utils.symlink(cache_path, link_path)

    def media_processing(self) -> None:
        self._pm.install_packages([
            'perl-image-exiftool',
            'ffmpeg',
            'imagemagick',
            'pdftk',
            'easytag',
        ])  # fmt: off

    def bluetooth(self) -> None:
        self._pm.install_packages([
            'bluez',
            'bluetui',
            'chntpw', # For extraction of pairing keys from Windows
            'python-dbus', # For bt-connection-notifier
        ])  # fmt: off

        systemd_dir_path = Path.home() / '.config/systemd/user'
        utils.mkdir(systemd_dir_path)
        utils.symlink_dotfile(Path('bluetooth/bt-connection-notifier.service'), systemd_dir_path)
        utils.run_shell_command('systemctl --user enable bt-connection-notifier')

        utils.copy_dotfile_as_root(Path('bluetooth/main.conf'), Path('/etc/bluetooth'))
        utils.run_shell_command('sudo systemctl enable bluetooth')

    def deluge(self) -> None:
        self._pm.install_packages([
            'deluge', 'deluge-gtk', 'gtk3', 'python-gobject', 'python-cairo', 'librsvg',
            'libappindicator-gtk3', 'libnotify'
        ])  # fmt: off

    def doublecmd(self):
        self._pm.install_packages(['doublecmd-qt5'])
        config_dir_path = Path.home() / '.config/doublecmd'
        utils.mkdir(config_dir_path)
        utils.copy_dotfile(Path('doublecmd/doublecmd.xml'), config_dir_path)

    def fontconfig(self) -> None:
        self._pm.install_packages([
            'noto-fonts',
            'noto-fonts-cjk',
            'noto-fonts-emoji',
            'ttf-nerd-fonts-symbols',
            'ttf-fira-code',
            'ttf-liberation',
            'ttf-roboto',
            'cantarell-fonts',
            'fontconfig',
        ])  # fmt: off

        config_dir_path = Path.home() / '.config/fontconfig'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('fontconfig/fonts.conf'), config_dir_path)

    def gimp(self) -> None:
        self._pm.install_packages(['gimp'])
        self.install_aur_packages(['xsane'])

        plugin_dir_path = Path.home() / '.config/GIMP/3.0/plug-ins/xsane'
        utils.mkdir(plugin_dir_path)
        utils.symlink_dotfile(Path('gimp/xsane.py'), plugin_dir_path)

    def git(self) -> None:
        self._pm.install_packages(['git', 'git-delta'])
        utils.copy_dotfile(Path('git/gitconfig'), Path.home(), hidden=True)
        utils.symlink_dotfile(Path('git/gitignore_global'), Path.home(), hidden=True)

    def gtk(self) -> None:
        self._pm.install_packages(['gtk2', 'gtk3', 'gtk4', 'polkit-gnome'])
        config_dir_path = Path.home() / '.config/gtk-3.0'
        config_4_dir_path = Path.home() / '.config/gtk-4.0'

        system_config_dir_path = Path('/etc/gtk-3.0')
        system_config_4_dir_path = Path('/etc/gtk-4.0')

        utils.mkdir(config_dir_path)
        utils.mkdir(config_4_dir_path)
        utils.run_shell_command(f'sudo mkdir -p "{system_config_dir_path}"')
        utils.run_shell_command(f'sudo mkdir -p "{system_config_4_dir_path}"')

        utils.symlink_dotfile(Path('gtk/gtk-3.0-settings.ini'), config_dir_path / 'settings.ini')
        utils.symlink_dotfile(Path('gtk/gtk-4.0-settings.ini'), config_4_dir_path / 'settings.ini')
        utils.copy_dotfile_as_root(
            Path('gtk/gtk-3.0-settings.ini'), system_config_dir_path / 'settings.ini'
        )
        utils.copy_dotfile_as_root(
            Path('gtk/gtk-4.0-settings.ini'), system_config_4_dir_path / 'settings.ini'
        )
        utils.symlink_dotfile(Path('gtk/gtkrc-2.0'), Path.home(), hidden=True)
        utils.run_shell_command('dconf load / < gtk/dconf.ini')

    def i3(self) -> None:
        self._pm.install_packages([
            'i3-wm', 'py3status',
            'i3lock',
            'dmenu', 'feh',
            'dunst', 'scrot',
            'python-pip', 'python-pytz', 'python-tzlocal', 'xorg-xset', 'xorg-xrandr'
        ])  # fmt: off
        utils.run_shell_command('pip install --user --break-system-packages -U pulsectl')

        config_dir_path = Path.home() / '.config/i3'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('i3/i3.config'), config_dir_path / 'config')
        utils.symlink_dotfile(Path('i3/i3-session'), config_dir_path)
        utils.symlink_dotfile(Path('i3/i3status.conf'), config_dir_path)
        utils.symlink_dotfile(Path('i3/py3status'), config_dir_path)

        self.install_aur_packages(['xkb-switch'])

    def lxdm(self) -> None:
        self._pm.install_packages(['lxdm-gtk3'])

        config_dir_path = Path('/etc/lxdm')
        themes_dir_path = Path('/usr/share/lxdm/themes')

        utils.copy_dotfile_as_root(Path('lxdm/lxdm.conf'), config_dir_path)
        utils.copy_dotfile_as_root(Path('lxdm/PostLogout'), config_dir_path)
        utils.extract_dotfile_tar_as_root(Path('theme/LXDM-Arch-Darkest.tar.gz'), themes_dir_path)

        self.install_aur_packages(['xinit-xsession', 'xkb-switch'])

        utils.run_shell_command('sudo systemctl enable lxdm')

    def picom(self) -> None:
        self._pm.install_packages(['picom'])
        config_dir_path = Path.home() / '.config'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('picom/picom.conf'), config_dir_path)

        self.systemd_config()
        systemd_dir_path = Path.home() / '.config/systemd/user'
        utils.symlink_dotfile(Path('picom/picom.service'), systemd_dir_path)
        utils.symlink_dotfile(Path('picom/stop-picom.service'), systemd_dir_path)
        utils.run_shell_command('systemctl --user enable picom stop-picom')

    def pipewire(self) -> None:
        self._pm.install_packages([
            'pipewire', 'pipewire-audio', 'pipewire-alsa', 'pipewire-pulse',
            'alsa-utils',
            'rtkit',
            'pavucontrol',
        ])  # fmt: off

        config_dir_path = Path.home() / '.config/pipewire/client.conf.d'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('pipewire/client.conf.d/resample.conf'), config_dir_path)

    def mcomix(self) -> None:
        self.install_aur_packages(['mcomix'])

    def mount_utils(self) -> None:
        self._pm.install_packages(['sshfs', 'cifs-utils', 'fuse3'])
        utils.run_shell_command('sudo mkdir -p /mnt/sftp /mnt/cifs')
        utils.run_shell_command('sudo chown ${USER}:users /mnt/sftp /mnt/cifs')
        user_bin_dir_path = Path.home() / '.local/bin'
        utils.mkdir(user_bin_dir_path)
        utils.symlink_dotfile(Path('mount-utils/wmount.sh'), user_bin_dir_path / 'wmount')
        utils.symlink_dotfile(Path('mount-utils/sftpmount.sh'), user_bin_dir_path / 'sftpmount')

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
                'words'
            ] + ([
                'gcc',
                'tree-sitter-cli',
                'global', 'python-pip', 'python-pygments',
                'ctags',
                'ruff', 'tidy', 'python-isort',
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
            ] if x11 else [])
        )  # fmt: off

        utils.run_shell_command('sudo ln -s -f -r $(which nvim) /usr/local/bin/vim')

        config_dir_path = Path.home() / '.config/nvim'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('neovim/init.lua'), config_dir_path)
        utils.symlink_dotfile(Path('neovim/lua'), config_dir_path)
        utils.symlink_dotfile(Path('neovim/after'), config_dir_path)
        utils.symlink_dotfile(Path('neovim/snippets'), config_dir_path)

        if developer:
            self.nodejs()
            utils.symlink_dotfile(Path('neovim/globalrc'), Path.home(), hidden=True)
            utils.symlink_dotfile(Path('neovim/ctags.conf'), Path.home() / '.ctags')
            utils.symlink_dotfile(
                Path('neovim/settings_developer.lua'), config_dir_path / 'dotfiles_settings.lua'
            )
        else:
            utils.symlink_dotfile(
                Path('neovim/settings_minimal.lua'), config_dir_path / 'dotfiles_settings.lua'
            )

        self.neovim_plugins(developer, True)

    def neovim_plugins(self, developer: bool = True, installation: bool = False) -> None:
        if developer:
            utils.run_shell_command(
                'pip install --user --break-system-packages -U cmakelang cmake-language-server'
            )
            utils.run_shell_command('cargo install openscad-lsp')
            utils.run_shell_command('npm install -g neovim vscode-langservers-extracted')

        try:
            if installation or not developer:
                utils.run_shell_command('nvim --headless "+Lazy! sync" "+qa"')
            else:
                utils.run_shell_command('nvim --headless "+Lazy! sync" "+TSUpdateSync" "+qa"')
        except KeyboardInterrupt:
            pass

    def nodejs(self) -> None:
        self._pm.install_packages(['nodejs', 'npm'])
        utils.symlink_dotfile(Path('nodejs/npmrc'), Path.home(), hidden=True)

    def qtconfig(self) -> None:
        self.install_aur_packages(['qt5-styleplugins', 'qt6gtk2'])
        config_dir_path = Path.home() / '.config'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('qtconfig/Trolltech.conf'), config_dir_path)

    def ranger(self, media_preview: bool = True) -> None:
        self._pm.install_packages(['ranger'] + (['ffmpegthumbnailer'] if media_preview else []))
        if media_preview:
            self.ueberzugpp()
        config_dir_path = Path.home() / '.config/ranger'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('ranger/rc.conf'), config_dir_path)
        utils.symlink_dotfile(Path('ranger/scope.sh'), config_dir_path)

    def yazi(self, media_preview: bool = True) -> None:
        self._pm.install_packages(['yazi'])
        if media_preview:
            self.ueberzugpp()
        config_dir_path = Path.home() / '.config/yazi'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('yazi/yazi.toml'), config_dir_path)
        utils.symlink_dotfile(Path('yazi/theme.toml'), config_dir_path)
        utils.symlink_dotfile(Path('yazi/init.lua'), config_dir_path)

    def systemd_config(self) -> None:
        config_dir_path = Path('/etc/systemd/system')
        utils.copy_dotfile_as_root(Path('systemd/system/pre-sleep@.service'), config_dir_path)
        utils.copy_dotfile_as_root(Path('systemd/system/post-sleep@.service'), config_dir_path)

        config_dir_path = Path.home() / '.config/systemd/user'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('systemd/user/pre-sleep.target'), config_dir_path)
        utils.symlink_dotfile(Path('systemd/user/post-sleep.target'), config_dir_path)

        u = getpass.getuser()
        utils.run_shell_command(f'sudo systemctl enable pre-sleep@{u} post-sleep@{u}')

    def ueberzugpp(self) -> None:
        self._pm.install_packages(['ueberzugpp'])
        config_dir_path = Path.home() / '.config/ueberzugpp'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('ueberzugpp/config.json'), config_dir_path)

    def samba(self) -> None:
        self._pm.install_packages(['samba'])
        samba_user = input('Enter Samba Username: ')
        utils.run_shell_command('sudo mkdir -p /etc/samba')
        utils.symlink_dotfile_with_root(Path('samba/smb.conf'), Path('/etc/samba/smb.conf'))
        utils.run_shell_command(
            'sudo sh -c "sed -e "s/HOST_NAME/$(hostname)/" samba/machine.conf > /etc/samba/machine.conf"'
        )

        utils.run_shell_command(f'sudo useradd {samba_user} -g users -s /bin/nologin')
        utils.run_shell_command(f'sudo smbpasswd -a {samba_user}')
        utils.run_shell_command(
            f'echo "{samba_user} = "{samba_user}"" | sudo tee -a /etc/samba/smbusers > /dev/null'
        )
        utils.run_shell_command('sudo systemctl enable smb')

    def scripts_dependencies(self) -> None:
        self._pm.install_packages(['python-pip'])
        utils.run_shell_command(
            'pip install --user --break-system-packages -U -r scripts/requirements.txt'
        )

    def vmic(self) -> None:
        self._pm.install_packages(['python-pip'])
        utils.run_shell_command('pip install --user --break-system-packages -U pulsectl')

        bin_dir_path = Path.home() / '.local/bin'
        utils.mkdir(bin_dir_path)
        utils.symlink_dotfile(Path('vmic/vmic'), bin_dir_path)

        config_dir_path = Path.home() / '.config/pipewire/pipewire.conf.d'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('vmic/10-virtual-sinks.conf'), config_dir_path)

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
        themes_dir_path = Path('/usr/share/themes')
        icons_dir_path = Path('/usr/share/icons')
        utils.run_shell_command(f'sudo mkdir -p {themes_dir_path}')
        utils.run_shell_command(f'sudo mkdir -p {icons_dir_path}')

        utils.extract_dotfile_tar_as_root(
            Path('theme/Flat-Remix-GTK-Blue-Darkest-20220627.tar.gz'), themes_dir_path
        )
        utils.extract_dotfile_tar_as_root(Path('theme/Arc-ICONS-1.5.7.tar.gz'), icons_dir_path)
        utils.extract_dotfile_tar_as_root(Path('theme/Future-Cyan-20230405.tar.gz'), icons_dir_path)

    def tmux(self) -> None:
        self._pm.install_packages(['tmux'])
        config_dir_path = Path.home() / '.config/tmux'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('tmux/tmux.conf'), config_dir_path)

    def vifm(self, media_preview: bool = True) -> None:
        self._pm.install_packages(['vifm', 'python-pygments'])
        if media_preview:
            self.ueberzugpp()
        config_dir_path = Path.home() / '.config/vifm'

        colors_dir_path = config_dir_path / 'colors'
        utils.mkdir(colors_dir_path)
        utils.symlink_dotfile(Path('vifm/vifmrc'), config_dir_path)
        utils.symlink_dotfile(Path('vifm/dircolors.vifm'), colors_dir_path)

        plugins_dir_path = config_dir_path / 'plugins'
        for plugin in ['devicons', 'ueberzugpp']:
            plug_dir_path = plugins_dir_path / plugin
            utils.mkdir(plug_dir_path)
            utils.symlink_dotfile(Path(f'vifm/{plugin}.lua'), plug_dir_path / 'init.lua')

        if media_preview:
            user_bin_dir_path = Path.home() / '.local/bin'
            utils.mkdir(user_bin_dir_path)
            utils.symlink_dotfile(Path('vifm/vifm-ueberzugpp-wrapper'), user_bin_dir_path / 'vifm')

    def wezterm(self) -> None:
        self._pm.install_packages(['wezterm'])
        config_dir_path = Path.home() / '.config/wezterm'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('wezterm/wezterm.lua'), config_dir_path)

    def kitty(self) -> None:
        self._pm.install_packages(['kitty'])
        config_dir_path = Path.home() / '.config/kitty'
        utils.mkdir(config_dir_path)
        utils.symlink_dotfile(Path('kitty/kitty.conf'), config_dir_path)

    def X11(self) -> None:
        self._pm.install_packages([
            'xorg-server', 'xorg-xinit', 'xorg-xkill', 'xorg-xhost', 'xorg-xev',
            'xdg-utils', 'perl-file-mimeinfo',
            'xterm'
        ])  # fmt: off

        config_dir_path = '/etc/X11/xorg.conf.d'
        utils.run_shell_command(f'sudo mkdir -p {config_dir_path}')
        utils.run_shell_command(f'sudo cp X11/00-keyboard.conf {config_dir_path}/')

        utils.symlink_dotfile(Path('X11/xinitrc'), Path.home(), hidden=True)
        utils.symlink_dotfile(Path('X11/Xresources'), Path.home(), hidden=True)

    def x11vnc(self) -> None:
        self._pm.install_packages(['x11vnc'])
        utils.run_shell_command('x11vnc -storepasswd')

    def xnviewmp(self) -> None:
        self.install_aur_packages(['xnviewmp-system-libs'])

    def zsh(self, developer: bool = True) -> None:
        self._pm.install_packages([
            'zsh', 'zsh-completions', 'zsh-syntax-highlighting',
            'fzf',
            'zoxide',
            'lsd',
            'which',
            'kitty-terminfo',
        ])  # fmt: off
        self.install_aur_packages(['zsh-theme-powerlevel10k-git'])

        utils.symlink_dotfile(Path('zsh/zshrc'), Path.home(), hidden=True)
        utils.symlink_dotfile(Path('zsh/zprofile'), Path.home(), hidden=True)
        utils.symlink_dotfile(Path('zsh/profile'), Path.home(), hidden=True)
        utils.symlink_dotfile(Path('zsh/p10k.zsh'), Path.home(), hidden=True)
        if developer:
            utils.symlink_dotfile(
                Path('zsh/settings_developer'), Path.home() / '.zsh_dotfiles_settings'
            )
        else:
            utils.symlink_dotfile(
                Path('zsh/settings_minimal'), Path.home() / '.zsh_dotfiles_settings'
            )

        utils.run_shell_command('sudo usermod -s $(which zsh) ${USER}')

        lsd_config_dir_path = Path.home() / '.config/lsd'
        utils.mkdir(lsd_config_dir_path)
        utils.symlink_dotfile(Path('zsh/lsd-config.yaml'), lsd_config_dir_path / 'config.yaml')
