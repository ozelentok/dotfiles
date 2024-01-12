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
        self._installer.base_packages()
        self._installer.zsh()
        self._installer.tmux()
        self._installer.mount_utils()
        self._installer.pikaur()
        self._installer.git()

        self._installer.neovim()
        self._installer.ranger()
        self._installer.scripts_dependencies()
        self._installer.sensors()
        self._installer.media_processing()

        self._installer.X11()
        self._installer.i3()
        self._installer.fontconfig()
        self._installer.gtk()
        self._installer.theme()
        self._installer.wezterm()

        self._installer.picom()
        self._installer.pulseaudio()
        self._installer.bluetooth()
        self._installer.vmic()
        self._installer.yt_dlp()

        self._installer.desktop_programs()
        self._installer.deluge()
        self._installer.doublecmd()
        self._installer.gimp()
        self._installer.mcomix()
        self._installer.mpv()
        self._installer.smplayer()
        self._installer.xnviewmp()
        self._installer.qtconfig()

    def upgrade(self) -> None:
        utils.run_shell_command('pikaur -Syu')
        self._installer.scripts_dependencies()
        self._installer.yt_dlp()
        self._installer.scripts_dependencies()


class Minimal(Profile):

    def neovim(self) -> None:
        self._installer.neovim(False, False)

    def ranger(self) -> None:
        self._installer.ranger(False)

    def install(self) -> None:
        self._installer.base_packages()
        self._installer.zsh()
        self._installer.tmux()
        self._installer.mount_utils()
        self._installer.git()

        self.neovim()
        self.ranger()
        self._installer.sensors()

    def upgrade(self) -> None:
        self._installer.scripts_dependencies()
        self._installer.neovim_plugins(False)
