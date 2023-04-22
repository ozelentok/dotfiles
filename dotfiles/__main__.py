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
    args = parser.parse_args()
    package = args.package

    installer = Installer()
    getattr(installer, package)()


if __name__ == '__main__':
    main()
