import argparse
import inspect

from .installer import Installer


def main():
    parser = argparse.ArgumentParser()
    packages = [
        m[0] for m in inspect.getmembers(Installer, predicate=inspect.isfunction)
        if not m[0].startswith('_')
    ]
    parser.add_argument('package',
                        default=Installer.all.__name__,
                        choices=packages,
                        nargs='?',
                        help='Package to install (default: all packages)')
    parser.add_argument('--skip-upgrade',
                        action='store_true',
                        help='Skip upgrading existing packages (for testing new packages)')

    args = parser.parse_args()
    package = args.package

    installer = Installer(args.skip_upgrade)
    getattr(installer, package)()


if __name__ == '__main__':
    main()
