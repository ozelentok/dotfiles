from abc import ABC, abstractmethod

from . import utils
from .installer import Installer


class Profile(ABC):
    def __init__(self, skip_upgrade=False):
        self._installer = Installer(skip_upgrade)

    @abstractmethod
    def install(self) -> None:
        pass

    @abstractmethod
    def upgrade(self) -> None:
        pass

    def install_package(self, name: str) -> None:
        pkg_installer = getattr(self, name, None)
        if not pkg_installer:
            pkg_installer = getattr(self._installer, name)
        pkg_installer()


class Full(Profile):
    def install(self) -> None:
        self._installer.tmpfs_programs_cache()
        self._installer.base_packages()
        self._installer.zsh()
        self._installer.tmux()
        self._installer.mount_utils()
        self._installer.pikaur()
        self._installer.git()
        self._installer.systemd_config()

        self._installer.neovim()
        self._installer.yazi()
        self._installer.ranger()
        self._installer.vifm()
        self._installer.scripts_dependencies()
        self._installer.sensors()
        self._installer.media_processing()

        self._installer.X11()
        self._installer.i3()
        self._installer.lxdm()
        self._installer.fontconfig()
        self._installer.gtk()
        self._installer.theme()
        self._installer.kitty()

        self._installer.picom()
        self._installer.pipewire()
        self._installer.bluetooth()
        self._installer.vmic()
        self._installer.yt_dlp()

        self._installer.desktop_programs()
        self._installer.mimeapps()
        self._installer.qbittorrent()
        self._installer.doublecmd()
        self._installer.gimp()
        self._installer.mcomix()
        self._installer.mpv()
        self._installer.smplayer()
        self._installer.xnviewmp()
        self._installer.qt()

    def upgrade(self) -> None:
        utils.run_command(["pikaur", "-Syu"])
        self._installer.scripts_dependencies()
        self._installer.yt_dlp()
        self._installer.neovim_plugins(True, False)


class Minimal(Profile):
    def zsh(self) -> None:
        self._installer.zsh(False)

    def neovim(self) -> None:
        self._installer.neovim(False, False)

    def yazi(self):
        self._installer.yazi(False)

    def ranger(self) -> None:
        self._installer.ranger(False)

    def vifm(self) -> None:
        self._installer.vifm(False)

    def install(self) -> None:
        self._installer.base_packages()
        self.zsh()
        self._installer.tmux()
        self._installer.mount_utils()
        self._installer.git()
        self._installer.pikaur()

        self.neovim()
        self.yazi()
        self.ranger()
        self.vifm()
        self._installer.sensors()

    def upgrade(self) -> None:
        utils.run_command(["pikaur", "-Syu"])
        self._installer.scripts_dependencies()
        self._installer.neovim_plugins(False, False)


class ShellOnly(Profile):
    def zsh(self) -> None:
        self._installer.zsh(False)

    def neovim(self) -> None:
        self._installer.neovim(False, False)

    def yazi(self):
        self._installer.yazi(False)

    def ranger(self) -> None:
        self._installer.ranger(False)

    def vifm(self) -> None:
        self._installer.vifm(False)

    def install(self) -> None:
        self.zsh()

    def upgrade(self) -> None:
        pass
