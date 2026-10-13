import argparse
import json
from pathlib import Path

from .installer import Installer
from .profiles import PROFILES

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
    common_options = argparse.ArgumentParser(add_help=False)
    common_options.add_argument(
        "-s",
        "--skip-upgrade",
        action="store_true",
        help="Skip upgrading existing system packages (for testing new packages)",
    )

    profile_parser = subparsers.add_parser(
        "profile", help="Install profile", parents=[common_options]
    )
    profile_parser.add_argument("profile", choices=PROFILES)

    profile_parser = subparsers.add_parser(
        "upgrade", help="Upgrade system", parents=[common_options]
    )

    package_parser = subparsers.add_parser("pkg", help="Install package", parents=[common_options])
    package_parser.add_argument("pkg", choices=Installer.list_packages())

    args = parser.parse_args()

    if args.action == "profile":
        save_profile_name(args.profile)
        PROFILES[args.profile](args.skip_upgrade).install()
        return

    profile = PROFILES[load_profile_name()](args.skip_upgrade)
    if args.action == "upgrade":
        profile.upgrade()
        return

    if args.action == "pkg":
        getattr(profile, args.pkg)()
        return


if __name__ == "__main__":
    main()
