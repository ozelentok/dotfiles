#!/usr/bin/env python3

import os
import subprocess
import sys
import traceback
from pathlib import Path
from tempfile import TemporaryDirectory

import gi

gi.require_version("Gimp", "3.0")
from gi.repository import Gimp, Gio, GLib, GObject # noqa: E402 # pyright: ignore


def run_xsane(procedure, config, run_data: Path, *args) -> Gimp.ValueArray:
    try:
        img_path = run_data

        proc = subprocess.Popen(
            [
                "xsane",
                "--save",
                "--no-mode-selection",
                "--force-filename",
                img_path,
                "--print-filenames",
            ],
            stdout=subprocess.PIPE,
            encoding="utf-8",
        )

        if proc.stdout is None:
            raise RuntimeError("No stdout stream")

        loaded_image = None
        while True:
            xsane_output_name = proc.stdout.readline().strip()
            if not xsane_output_name:
                break

            if xsane_output_name != f"XSANE_IMAGE_FILENAME: {img_path}":
                raise RuntimeError(f"Unexpected XSane output: {xsane_output_name}")

            loaded_image = Gimp.file_load(
                Gimp.RunMode.NONINTERACTIVE, Gio.File.new_for_path(str(img_path))
            )
            Gimp.Display.new(loaded_image)

            os.unlink(img_path)

        if not loaded_image:
            return procedure.new_return_values(Gimp.PDBStatusType.CANCEL)

        return procedure.new_return_values(Gimp.PDBStatusType.SUCCESS)

    except Exception:
        return procedure.new_return_values(
            Gimp.PDBStatusType.EXECUTION_ERROR, GLib.Error(traceback.format_exc())
        )


class XSaneTemporaryDirectory:
    def __init__(self) -> None:
        parent_cache_dir = os.environ.get("XDG_RUNTIME_DIR")
        self._temp_dir = TemporaryDirectory(prefix="gimp-xsane-", dir=parent_cache_dir)

    def get_image_path(self) -> Path:
        return Path(self._temp_dir.name, "xsane_scan.png")


class XSanePlugin(Gimp.PlugIn):
    def __init__(self, *args, **kwargs) -> None:
        super().__init__(*args, **kwargs)
        self._temp_dir = XSaneTemporaryDirectory()

    def do_set_i18n(self, name) -> bool:
        return False

    def do_query_procedures(self) -> list[str]:
        return ["plug-in-xsane"]

    def do_create_procedure(self, name):
        if name != "plug-in-xsane":
            raise RuntimeError("Unknown procedure")

        procedure = Gimp.Procedure.new(
            self,
            name,
            Gimp.PDBProcType.PLUGIN,
            run_xsane,
            self._temp_dir.get_image_path(),
            None,
        )
        procedure.set_menu_label("_Scan using XSane")
        procedure.add_menu_path("<Image>/File/Create")
        procedure.add_enum_argument(
            "run-mode",
            "Run mode",
            "The run mode",
            Gimp.RunMode.__gtype__,
            Gimp.RunMode.NONINTERACTIVE,
            GObject.ParamFlags.READWRITE,
        )
        procedure.add_image_return_value(
            "image", "Image", "Output image", False, GObject.ParamFlags.READWRITE
        )

        return procedure


if __name__ == "__main__":
    Gimp.main(XSanePlugin.__gtype__, sys.argv)
