import functools
import os
import shutil
import subprocess
from pathlib import Path
from typing import Callable

__MOUDLE_PATH = Path(os.path.dirname(os.path.abspath(__file__)))


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
        pacman_options = self._pacman_options

        # When running as root, avoid reinstalling existing AUR packages
        if os.geteuid() == 0:
            packages = [p for p in packages if subprocess.run(["pacman", "-Q", p]).returncode != 0]
            pacman_options = "-S"

        subprocess.check_call(["pikaur", pacman_options, "--needed", "--noconfirm"] + packages)


def run_shell_command(command: str | list[str]) -> None:
    subprocess.check_call(command, shell=True, cwd=__MOUDLE_PATH)


def mkdir(path: Path) -> None:
    path.mkdir(parents=True, exist_ok=True)


def symlink(src_path: Path, dst_path: Path) -> None:
    if dst_path.is_symlink() and dst_path.readlink() == src_path:
        return
    if dst_path.exists() or dst_path.is_symlink():
        dst_path.unlink()
    dst_path.symlink_to(src_path)


def symlink_relative(src_path: Path, dst_path: Path, hidden: bool = False) -> None:
    if dst_path.is_dir() and not dst_path.is_symlink():
        dst_path /= ("." if hidden else "") + src_path.name
    rel_target_path = os.path.relpath(src_path, dst_path.parent)
    if dst_path.is_symlink() and dst_path.readlink() == rel_target_path:
        return
    if dst_path.exists() or dst_path.is_symlink():
        dst_path.unlink()
    dst_path.symlink_to(rel_target_path)


def symlink_dotfile(dotfile_path: Path, dst_path: Path, hidden: bool = False) -> None:
    symlink_relative(__MOUDLE_PATH / dotfile_path, dst_path, hidden)


def symlink_dotfile_with_root(dotfile_path: Path, dst_path: Path, hidden: bool = False) -> None:
    if dst_path.is_dir() and not dst_path.is_symlink():
        dst_path /= ("." if hidden else "") + dotfile_path.name
    src_path = __MOUDLE_PATH / dotfile_path
    run_shell_command(
        " ".join(["sudo", "ln", "-s", "-f", src_path.as_posix(), dst_path.as_posix()])
    )


def copy_dotfile(dotfile_path: Path, dst_path: Path, hidden: bool = False) -> None:
    if dst_path.is_dir():
        dst_path /= ("." if hidden else "") + dotfile_path.name

    src_path = __MOUDLE_PATH / dotfile_path
    if dst_path.exists():
        src_stat = src_path.stat()
        dst_stat = dst_path.stat()
        if src_stat.st_mtime != dst_stat.st_mtime:
            dst_path.unlink()
    shutil.copy2(src_path, dst_path)


def copy_dotfile_as_root(dotfile_path: Path, dst_path: Path, hidden: bool = False) -> None:
    if dst_path.is_dir():
        dst_path /= ("." if hidden else "") + dotfile_path.name

    src_path = __MOUDLE_PATH / dotfile_path
    subprocess.check_call(["sudo", "cp", src_path, dst_path], cwd=__MOUDLE_PATH)


def extract_dotfile_tar(dotfile_tar_path: Path, dst_dir_path: Path):
    src_path = __MOUDLE_PATH / dotfile_tar_path
    subprocess.check_call(["tar", "-xf", src_path, "-C", dst_dir_path])


def extract_dotfile_tar_as_root(dotfile_tar_path: Path, dst_dir_path: Path):
    src_path = __MOUDLE_PATH / dotfile_tar_path
    subprocess.check_call(
        [
            "sudo",
            "tar",
            "--no-same-owner",
            "--no-same-permissions",
            "-xf",
            src_path,
            "-C",
            dst_dir_path,
        ]
    )


def avoid_reinstall(executable: str):
    def decorator(f: Callable) -> Callable:
        @functools.wraps(f)
        def wrapper(*args, **kwargs):
            if shutil.which(executable) is None:
                return f(*args, **kwargs)

        return wrapper

    return decorator
