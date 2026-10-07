import subprocess
import tempfile


class SystemPackageManager:
    _pacman_options = "-Syu"

    def __init__(self, skip_upgrade=False):
        if skip_upgrade:
            self._pacman_options = "-S"

    def install_packages(self, packages: list[str]) -> None:
        subprocess.check_call(
            ["sudo", "pacman", self._pacman_options, "--needed", "--noconfirm"] + packages
        )

    def install_aur_packages(self, packages: list[str]) -> None:
        packages = [p for p in packages if not self.is_installed(p)]
        if not packages:
            return

        self.install_pikaur()
        subprocess.check_call(["pikaur", "-S", "--needed", "--noconfirm"] + packages)

    def is_installed(self, package: str) -> bool:
        result = subprocess.run(
            ["pacman", "-Q", package],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
            check=False,
        )
        return result.returncode == 0

    def install_pikaur(self) -> None:
        if self.is_installed("pikaur"):
            return

        self.install_packages(["base-devel", "git"])
        with tempfile.TemporaryDirectory() as tmp_build_path:
            subprocess.check_call(
                ["git", "clone", "https://aur.archlinux.org/pikaur.git", tmp_build_path]
            )
            subprocess.check_call(
                ["makepkg", "-scir", "--needed", "--noconfirm"], cwd=tmp_build_path
            )

    def upgrade(self) -> None:
        if self.is_installed("pikaur"):
            subprocess.check_call(["pikaur", "-Syu"])
        else:
            subprocess.check_call(["sudo", "pacman", "-Syu"])
