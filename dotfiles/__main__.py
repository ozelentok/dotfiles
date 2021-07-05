import argparse
import inspect
from .installer import Installer


def main():
    parser = argparse.ArgumentParser()
    packages = [m[0] for m in inspect.getmembers(Installer, predicate=inspect.ismethod)]
    parser.add_argument('package',
                        default=Installer.all.__name__,
                        choices=packages,
                        nargs='?',
                        help='Package to install (default: all packages)')
    package = parser.parse_args().package
    getattr(Installer, package)()


if __name__ == '__main__':
    main()
