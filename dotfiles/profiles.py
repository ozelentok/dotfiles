from abc import ABC, abstractmethod

from .installer import Installer


class Profile(Installer, ABC):
    @abstractmethod
    def install(self) -> None:
        pass

    @abstractmethod
    def upgrade(self) -> None:
        pass


class Full(Profile):
    def install(self) -> None:
        self.tmpfs_programs_cache()
        self.base_packages()
        self.zsh()
        self.tmux()
        self.mount_utils()
        self.git()
        self.systemd_config()

        self.neovim()
        self.yazi()
        self.ranger()
        self.vifm()
        self.scripts_dependencies()
        self.sensors()
        self.media_processing()

        self.gtk()
        self.qt()
        self.theme()
        self.fontconfig()
        self.sway()
        self.greetd()
        self.kitty()

        self.pipewire()
        self.bluetooth()
        self.vmic()
        self.yt_dlp()

        self.desktop_programs()
        self.mimeapps()
        self.qbittorrent()
        self.doublecmd()
        self.gimp()
        self.mcomix()
        self.mpv()
        self.smplayer()
        self.xnviewmp()
        self.speech_dispatcher()

    def upgrade(self) -> None:
        self.upgrade_packages()
        self.scripts_dependencies()
        self.yt_dlp()
        self.neovim_plugins()


class Minimal(Profile):
    def __init__(self, skip_upgrade=False):
        super().__init__(skip_upgrade, developer=False, wayland=False, media_preview=False)

    def install(self) -> None:
        self.base_packages()
        self.zsh()
        self.tmux()
        self.mount_utils()
        self.git()

        self.neovim()
        self.yazi()
        self.ranger()
        self.vifm()
        self.sensors()

    def upgrade(self) -> None:
        self.upgrade_packages()
        self.scripts_dependencies()
        self.neovim_plugins()


class ShellOnly(Profile):
    def __init__(self, skip_upgrade=False):
        super().__init__(skip_upgrade, developer=False, wayland=False, media_preview=False)

    def install(self) -> None:
        self.zsh()

    def upgrade(self) -> None:
        self.upgrade_packages()


PROFILES = {
    "full": Full,
    "minimal": Minimal,
    "shellonly": ShellOnly,
}
