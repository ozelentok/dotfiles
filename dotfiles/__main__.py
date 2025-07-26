import argparse
import json
from pathlib import Path

from . import profiles
from .installer import Installer

__MODULE_PATH = Path(__file__).parent.absolute()
__PROFILE_NAME_FILE = ".profile.json"


def save_profile_name(profile_name: str) -> None:
    with open(__MODULE_PATH / __PROFILE_NAME_FILE, "w") as f:
        json.dump({"profile": profile_name}, f)


def load_profile_name() -> str:
    with open(__MODULE_PATH / __PROFILE_NAME_FILE, "r") as f:
        return json.load(f)["profile"]


def main():
    parser = argparse.ArgumentParser(prog="dotf")
    subparsers = parser.add_subparsers(dest="action", required=True)

    profile_parser = subparsers.add_parser("profile", help="Install profile")
    profile_parser.add_argument(
        "profile", choices=[p.__name__ for p in profiles.Profile.__subclasses__()]
    )

    profile_parser = subparsers.add_parser("upgrade", help="Upgrade system")

    package_parser = subparsers.add_parser("pkg", help="Install package")
    package_parser.add_argument("pkg", choices=Installer.list_packages())
    package_parser.add_argument(
        "-s",
        "--skip-upgrade",
        action="store_true",
        help="Skip upgrading existing system packages (for testing new packages)",
    )

    args = parser.parse_args()

    if args.action == "profile":
        save_profile_name(args.profile)
        getattr(profiles, args.profile)().install()
        return

    profile_name = load_profile_name()
    profile: type = getattr(profiles, profile_name)
    if args.action == "upgrade":
        profile().upgrade()
        return

    if args.action == "pkg":
        profile(args.skip_upgrade).install_package(args.pkg)
        return


if __name__ == "__main__":
    main()
