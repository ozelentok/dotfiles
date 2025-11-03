import getpass
import inspect
import os
import platform
import shutil
import subprocess
import tempfile
from pathlib import Path

from . import utils


class Installer:
    def __init__(self, skip_upgrade=False) -> None:
        self._pm = utils.SystemPackageManager(skip_upgrade)

    @classmethod
    def list_packages(cls) -> list[str]:
        return [
            m[0]
            for m in inspect.getmembers(cls, predicate=inspect.isfunction)
            if not m[0].startswith("_")
        ]

    def _mkdir(self, name: str, parent_dir: str | Path = Path.home() / ".config") -> Path:
        dir_path = Path(parent_dir) / name
        if dir_path.exists():
            return dir_path

        if os.access(parent_dir, os.W_OK):
            utils.mkdir(dir_path)
        else:
            utils.run_command(["sudo", "mkdir", "-p", str(dir_path)])
        return dir_path

    def install_aur_packages(self, packages: list[str]) -> None:
        self.pikaur()
        packages = [p for p in packages if not utils.is_installed(p)]
        subprocess.check_call(["pikaur", "-S", "--needed", "--noconfirm"] + packages)

    def pikaur(self) -> None:
        if utils.is_installed("pikaur"):
            return

        self._pm.install_packages(["base-devel", "git"])
        with tempfile.TemporaryDirectory() as tmp_build_path:
            subprocess.check_call(
                ["git", "clone", "https://aur.archlinux.org/pikaur.git", tmp_build_path]
            )
            subprocess.check_call(
                ["makepkg", "-scir", "--needed", "--noconfirm"], cwd=tmp_build_path
            )

    def base_packages(self) -> None:
        self._pm.install_packages([
            "htop",
            "plocate",
            "fd",
            "ripgrep",
            "unrar",
            "7zip",
            "unzip",
            "rsync",
            "strace",
            "lsof",
            "man",

            "inetutils",
            "net-tools",
            "bind",

            "polkit",

            "ntfs-3g",
            "exfat-utils", "fuse-exfat",
        ])  # fmt: off

    def desktop_programs(self) -> None:
        self._pm.install_packages([
            "firefox",
            "chromium",
            "keepassxc",
            "evince",
            "rdesktop",
            "audacity",
            "wireshark-qt",
            "libreoffice-fresh",
            "wine",
            "vlc",
            "playerctl",
        ])  # fmt: off

    def tmpfs_programs_cache(self) -> None:
        runtime_dir = Path(os.environ["XDG_RUNTIME_DIR"])
        runtime_cache = runtime_dir / "cache"
        runtime_cache.mkdir(exist_ok=True)
        links = [
            Path.home() / ".cache/doublecmd",
            Path.home() / ".cache/gimp",
            Path.home() / ".cache/mozilla",
            Path.home() / ".cache/nvim",
            Path.home() / ".cache/thumbnails",
            Path.home() / ".cache/ueberzugpp",
            Path.home() / ".cache/pikaur/build",
            Path.home() / ".mozilla/firefox/firefox-mpris",
            Path.home() / ".wine/drive_c/users" / getpass.getuser() / "Temp",
        ]
        for link_path in links:
            parent_path = link_path.parent
            utils.mkdir(parent_path)
            cache_path = runtime_cache / link_path.name
            # Cache dirs are also created at login by $HOME/.profile
            cache_path.mkdir(exist_ok=True)
            if link_path.exists() and not link_path.is_symlink():
                print(f"Deleting non-tmpfs linked cache directory: {link_path}")
                shutil.rmtree(link_path)
            utils.symlink(cache_path, link_path)

    def media_processing(self) -> None:
        self._pm.install_packages([
            "perl-image-exiftool",
            "ffmpeg",
            "imagemagick",
            "pdftk",
            "easytag",
        ])  # fmt: off

    def bluetooth(self) -> None:
        self._pm.install_packages([
            "bluez",
            "bluez-utils",
            "bluetui",
            "chntpw", # For extraction of pairing keys from Windows
            "python-dbus", # For bt-connection-notifier
        ])  # fmt: off

        systemd_dir_path = self._mkdir("systemd/user")
        utils.symlink_dotfile("bluetooth/bt-connection-notifier.service", systemd_dir_path)
        utils.run_command(["systemctl", "--user", "enable", "bt-connection-notifier"])

        utils.copy_dotfile_as_root("bluetooth/main.conf", "/etc/bluetooth")
        utils.run_command(["sudo", "systemctl", "enable", "bluetooth"])

    def doublecmd(self):
        self._pm.install_packages(["doublecmd-qt5"])
        config_dir_path = self._mkdir("doublecmd")
        utils.copy_dotfile("doublecmd/doublecmd.xml", config_dir_path)

    def fontconfig(self) -> None:
        self._pm.install_packages([
            "noto-fonts",
            "noto-fonts-cjk",
            "noto-fonts-emoji",
            "ttf-nerd-fonts-symbols",
            "ttf-fira-code",
            "ttf-liberation",
            "ttf-roboto",
            "adwaita-fonts",
            "fontconfig",
        ])  # fmt: off

        config_dir_path = self._mkdir("fontconfig")
        utils.symlink_dotfile("fontconfig/fonts.conf", config_dir_path)

    def gimp(self) -> None:
        self._pm.install_packages(["gimp"])
        self.install_aur_packages(["xsane"])

        plugin_dir_path = self._mkdir("GIMP/3.0/plug-ins/xsane")
        utils.symlink_dotfile("gimp/xsane.py", plugin_dir_path)

    def git(self) -> None:
        self._pm.install_packages(["git", "git-delta"])
        utils.copy_dotfile("git/gitconfig", Path.home(), hidden=True)
        utils.symlink_dotfile("git/gitignore_global", Path.home(), hidden=True)

    def gtk(self) -> None:
        self._pm.install_packages([
            "gtk2",
            "gtk3",
            "gtk4",
            "polkit-gnome",
            "xdg-desktop-portal-gtk",
        ])  # fmt: off

        for v in (3, 4):
            gtk_version = f"gtk-{v}.0"
            config_dir_path = self._mkdir(gtk_version)
            system_config_dir_path = self._mkdir(gtk_version, "/etc")

            gtk_ini_path = f"gtk/{gtk_version}-settings.ini"
            utils.symlink_dotfile(gtk_ini_path, config_dir_path / "settings.ini")
            utils.copy_dotfile_as_root(gtk_ini_path, system_config_dir_path / "settings.ini")

        utils.symlink_dotfile("gtk/gtkrc-2.0", Path.home(), hidden=True)
        utils.run_shell("dconf load / < gtk/dconf.ini")

    def sway(self) -> None:
        self._pm.install_packages([
            "sway", "swaybg", "swayidle", "swaylock",
            "wmenu",
            "j4-dmenu-desktop",
            "swaync",
            "grim", "slurp",
            "waybar",
            "foot",
            "xdg-desktop-portal-wlr",
            "wlr-randr",
            "xorg-xwayland",
        ])  # fmt: off
        utils.run_command(["pip", "install", "--user", "--break-system-packages", "-U", "pulsectl"])

        utils.copy_dotfile_as_root("sway/sway-wrapper", "/usr/local/bin/sway")
        utils.copy_dotfile_as_root("sway/swayidle-wrapper", "/usr/local/bin/swayidle")

        config_dir_path = self._mkdir("sway")
        utils.symlink_dotfile("sway/config", config_dir_path)

        config_dir_path = self._mkdir("xdg-desktop-portal")
        utils.symlink_dotfile("sway/portals.conf", config_dir_path)

        config_dir_path = self._mkdir("swaync")
        utils.symlink_dotfile("swaync/config.json", config_dir_path)
        utils.symlink_dotfile("swaync/style.css", config_dir_path)

        config_dir_path = self._mkdir("waybar")
        utils.symlink_dotfile("waybar/config.jsonc", config_dir_path)
        utils.symlink_dotfile("waybar/style.css", config_dir_path)

        config_dir_path = self._mkdir("foot")
        utils.symlink_dotfile("foot/foot.ini", config_dir_path)

        systemd_dir_path = self._mkdir("systemd/user")
        utils.symlink_dotfile("waybar/waybar-reload.service", systemd_dir_path)
        utils.run_command(["systemctl", "--user", "enable", "waybar-reload"])

    def greetd(self) -> None:
        self._pm.install_packages(["greetd", "greetd-regreet"])
        config_dir_path = self._mkdir("greetd", "/etc")
        utils.copy_dotfile_as_root("greetd/config.toml", config_dir_path)
        utils.copy_dotfile_as_root("greetd/sway-config", config_dir_path)
        utils.copy_dotfile_as_root("greetd/regreet.toml", config_dir_path)
        utils.copy_dotfile_as_root("greetd/regreet.css", config_dir_path)
        utils.run_command(["sudo", "systemctl", "enable", "greetd"])

    def pipewire(self) -> None:
        self._pm.install_packages([
            "pipewire", "pipewire-audio", "pipewire-alsa", "pipewire-pulse",
            "alsa-utils",
            "rtkit",
            "pavucontrol",
        ])  # fmt: off

        config_dir_path = self._mkdir("pipewire/client.conf.d")
        utils.symlink_dotfile("pipewire/client.conf.d/resample.conf", config_dir_path)

    def mcomix(self) -> None:
        self.install_aur_packages(["mcomix"])

    def mount_utils(self) -> None:
        self._pm.install_packages(["sshfs", "cifs-utils", "fuse3"])

        sftp_dir = self._mkdir("sftp", "/mnt")
        cifs_dir = self._mkdir("cifs", "/mnt")
        utils.run_command(
            ["sudo", "chown", f"{getpass.getuser()}:users", str(sftp_dir), str(cifs_dir)]
        )

        user_bin_dir_path = self._mkdir(".local/bin", Path.home())
        utils.symlink_dotfile("mount-utils/wmount.sh", user_bin_dir_path / "wmount")
        utils.symlink_dotfile("mount-utils/sftpmount.sh", user_bin_dir_path / "sftpmount")

    def mimeapps(self) -> None:
        utils.symlink_dotfile("mimeapps/mimeapps.list", Path.home() / ".config")

    def mpv(self) -> None:
        self._pm.install_packages(["mpv"])
        config_dir_path = self._mkdir("mpv")
        utils.symlink_dotfile("mpv/mpv.conf", config_dir_path)

    def neovim(self, developer: bool = True, wayland: bool = True) -> None:
        packages = ["neovim", "python-neovim", "words"]
        if developer:
            packages.extend(
                [
                    "gcc",
                    "tree-sitter-cli",
                    "global",
                    "python-pip",
                    "python-pygments",
                    "ctags",
                    "ruff",
                    "tidy",
                    "python-isort",
                    "pyright",
                    "clang",
                    "rust",
                    "nodejs",
                    "npm",
                    "eslint",
                    "lua-language-server",
                    "bash-language-server",
                    "arduino-language-server",
                    "yamllint",
                    "sqlfluff",
                ]
            )
        if wayland:
            packages.append("wl-clipboard")

        self._pm.install_packages(packages)
        utils.run_command(["sudo", "ln", "-s", "-f", "-r", "/usr/bin/nvim", "/usr/local/bin/vim"])

        config_dir_path = self._mkdir("nvim")
        utils.symlink_dotfile("neovim/init.lua", config_dir_path)
        utils.symlink_dotfile("neovim/lua", config_dir_path)
        utils.symlink_dotfile("neovim/after", config_dir_path)
        utils.symlink_dotfile("neovim/snippets", config_dir_path)

        if developer:
            self.nodejs()
            utils.symlink_dotfile("neovim/globalrc", Path.home(), hidden=True)
            utils.symlink_dotfile("neovim/ctags.conf", Path.home() / ".ctags")
            utils.symlink_dotfile(
                "neovim/settings_developer.lua", config_dir_path / "dotfiles_settings.lua"
            )
        else:
            utils.symlink_dotfile(
                "neovim/settings_minimal.lua", config_dir_path / "dotfiles_settings.lua"
            )

        self.neovim_plugins(developer)

    def neovim_plugins(self, developer: bool = True) -> None:
        if developer:
            utils.run_command(
                [
                    "pip",
                    "install",
                    "--user",
                    "--break-system-packages",
                    "-U",
                    "cmakelang",
                    "cmake-language-server",
                    "pyrefly",
                ]
            )
            utils.run_command(["cargo", "install", "openscad-lsp"])
            utils.run_command(["npm", "install", "-g", "neovim", "vscode-langservers-extracted"])

        try:
            utils.run_command(["nvim", "--headless", "+Lazy! sync", "+qa"])
        except KeyboardInterrupt:
            pass

    def nodejs(self) -> None:
        self._pm.install_packages(["nodejs", "npm"])
        utils.symlink_dotfile("nodejs/npmrc", Path.home(), hidden=True)

    def qt(self) -> None:
        self._pm.install_packages([
            "qt5ct", "qt6ct",
            "qt5-wayland", "qt6-wayland"
        ])  # fmt: off
        for v in (5, 6):
            colors_dir_path = self._mkdir(f"qt{v}ct/colors", "/usr/share")
            utils.copy_dotfile_as_root("qt/darkest.conf", colors_dir_path)

            config_dir_path = self._mkdir(f"qt{v}ct")
            utils.symlink_dotfile(f"qt/qt{v}ct.conf", config_dir_path)

    def qbittorrent(self) -> None:
        self._pm.install_packages(["qbittorrent"])

    def ranger(self, media_preview: bool = True) -> None:
        self._pm.install_packages(["ranger"] + (["ffmpegthumbnailer"] if media_preview else []))
        if media_preview:
            self.ueberzugpp()
        config_dir_path = self._mkdir("ranger")
        utils.symlink_dotfile("ranger/rc.conf", config_dir_path)
        utils.symlink_dotfile("ranger/scope.sh", config_dir_path)

    def yazi(self, media_preview: bool = True) -> None:
        self._pm.install_packages(["yazi"])
        if media_preview:
            self.ueberzugpp()
        config_dir_path = self._mkdir("yazi")
        utils.symlink_dotfile("yazi/yazi.toml", config_dir_path)
        utils.symlink_dotfile("yazi/theme.toml", config_dir_path)
        utils.symlink_dotfile("yazi/init.lua", config_dir_path)

    def systemd_config(self) -> None:
        config_dir_path = Path("/etc/systemd/system")
        utils.copy_dotfile_as_root("systemd/system/pre-sleep@.service", config_dir_path)
        utils.copy_dotfile_as_root("systemd/system/post-sleep@.service", config_dir_path)

        config_dir_path = self._mkdir("systemd/user")
        utils.symlink_dotfile("systemd/user/pre-sleep.target", config_dir_path)
        utils.symlink_dotfile("systemd/user/post-sleep.target", config_dir_path)

        user = getpass.getuser()
        utils.run_command(
            ["sudo", "systemctl", "enable", f"pre-sleep@{user}", f"post-sleep@{user}"]
        )

    def ueberzugpp(self) -> None:
        self._pm.install_packages(["ueberzugpp"])
        config_dir_path = self._mkdir("ueberzugpp")
        utils.symlink_dotfile("ueberzugpp/config.json", config_dir_path)

    def samba(self) -> None:
        self._pm.install_packages(["samba"])
        samba_user = input("Enter Samba Username: ")
        config_dir_path = self._mkdir("samba, /etc")
        utils.copy_dotfile_as_root("samba/smb.conf", config_dir_path)
        utils.copy_dotfile_as_root("samba/machine.conf", config_dir_path)

        hostname = platform.uname().node
        utils.run_command(
            ["sudo", "sed", "-i", "-e", f"s/HOST_NAME/{hostname}/", "/etc/samba/machine.conf"]
        )
        utils.run_command(["sudo", "useradd", samba_user, "-g", "users", "-s", "/bin/nologin"])
        utils.run_command(["sudo", "smbpasswd", "-a", samba_user])
        utils.run_command(
            ["sudo", "tee", "-a", "/etc/samba/smbusers"], input=f"{samba_user} = {samba_user}"
        )
        utils.run_command(["sudo", "systemctl", "enable", "smb"])

    def scripts_dependencies(self) -> None:
        self._pm.install_packages(["python-pip"])
        utils.run_command(
            [
                "pip",
                "install",
                "--user",
                "--break-system-packages",
                "-U",
                "-r",
                "scripts/requirements.txt",
            ]
        )

    def vmic(self) -> None:
        self._pm.install_packages(["python-pip"])
        utils.run_command(["pip", "install", "--user", "--break-system-packages", "-U", "pulsectl"])

        bin_dir_path = self._mkdir(".local/bin", Path.home())
        utils.symlink_dotfile("vmic/vmic", bin_dir_path)

        config_dir_path = self._mkdir("pipewire/pipewire.conf.d")
        utils.symlink_dotfile("vmic/10-virtual-sinks.conf", config_dir_path)

    def yt_dlp(self) -> None:
        self._pm.install_packages(["python-pip"])
        utils.run_command(["pip", "install", "--user", "--break-system-packages", "-U", "yt_dlp"])

    def sensors(self) -> None:
        self._pm.install_packages(["lm_sensors"])
        utils.run_command(["sudo", "sensors-detect"])

    def smplayer(self) -> None:
        self._pm.install_packages(["smplayer"])
        config_dir_path = self._mkdir(".config/smplayer")
        utils.copy_dotfile("smplayer/smplayer.ini", config_dir_path)

    def theme(self) -> None:
        themes_dir_path = self._mkdir("themes", "/usr/share")
        icons_dir_path = self._mkdir("icons", "/usr/share")

        utils.extract_dotfile_tar_as_root(
            "theme/Flat-Remix-GTK-Blue-20240730.tar.xz", themes_dir_path
        )
        utils.extract_dotfile_tar_as_root("theme/Flat-Remix-Blue-20250709.tar.xz", icons_dir_path)
        utils.extract_dotfile_tar_as_root("theme/Future-Cyan-20230405.tar.gz", icons_dir_path)
        for icon_dir in icons_dir_path.iterdir():
            if icon_dir.is_dir():
                utils.run_command(["sudo", "gtk-update-icon-cache", "-t", "-f", "-q", str(icon_dir)])

    def tmux(self) -> None:
        self._pm.install_packages(["tmux"])
        config_dir_path = self._mkdir("tmux")
        utils.symlink_dotfile("tmux/tmux.conf", config_dir_path)

    def vifm(self, media_preview: bool = True) -> None:
        self._pm.install_packages(["vifm", "python-pygments"])
        if media_preview:
            self.ueberzugpp()

        config_dir_path = self._mkdir("vifm")

        colors_dir_path = self._mkdir("colors", config_dir_path)
        utils.symlink_dotfile("vifm/vifmrc", config_dir_path)
        utils.symlink_dotfile("vifm/dircolors.vifm", colors_dir_path)

        plugins_dir_path = self._mkdir("plugins", config_dir_path)
        for plugin in ["devicons", "ueberzugpp"]:
            plug_dir_path = self._mkdir(plugin, plugins_dir_path)
            utils.symlink_dotfile(f"vifm/{plugin}.lua", plug_dir_path / "init.lua")

        if media_preview:
            bin_dir_path = self._mkdir(".local/bin", Path.home())
            utils.symlink_dotfile("vifm/vifm-ueberzugpp-wrapper", bin_dir_path / "vifm")

    def wezterm(self) -> None:
        self._pm.install_packages(["wezterm"])
        config_dir_path = self._mkdir("wezterm")
        utils.symlink_dotfile("wezterm/wezterm.lua", config_dir_path)

    def kitty(self) -> None:
        self._pm.install_packages(["kitty"])
        config_dir_path = self._mkdir("kitty")
        utils.symlink_dotfile("kitty/kitty.conf", config_dir_path)

    def xnviewmp(self) -> None:
        self.install_aur_packages(["xnviewmp-system-libs"])

    def zsh(self, developer: bool = True) -> None:
        self._pm.install_packages([
            "zsh", "zsh-completions", "zsh-syntax-highlighting",
            "fzf",
            "bat",
            "zoxide",
            "lsd",
            "which",
            "kitty-terminfo",
        ])  # fmt: off
        self.install_aur_packages(["zsh-theme-powerlevel10k-git"])

        utils.symlink_dotfile("zsh/zshrc", Path.home(), hidden=True)
        utils.symlink_dotfile("zsh/zprofile", Path.home(), hidden=True)
        utils.symlink_dotfile("zsh/profile", Path.home(), hidden=True)
        utils.symlink_dotfile("zsh/p10k.zsh", Path.home(), hidden=True)
        if developer:
            utils.symlink_dotfile("zsh/settings_developer", Path.home() / ".zsh_dotfiles_settings")
        else:
            utils.symlink_dotfile("zsh/settings_minimal", Path.home() / ".zsh_dotfiles_settings")

        utils.run_shell("sudo usermod -s $(which zsh) ${USER}")

        lsd_config_dir_path = self._mkdir("lsd")
        utils.symlink_dotfile("zsh/lsd-config.yaml", lsd_config_dir_path / "config.yaml")
