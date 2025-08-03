#!/usr/bin/env python3
"""
When institutional network Matlab licenses are renewed,
Matlab might not be startable to reactivate the license.
Hence we have a convenient Python script to find the MathWorksProductAuthorizer
program used to re-activate the Matlab license.

After running the MathWorksProductAuthorizer executable found by this script,
Matlab should be able to start again.
If license error 5201 still occurs upon starting Matlab, try rebooting the computer.
This might be necessary because the Matlab service might be used in the background by other programs
like Visual Studio Code or JupyterLab.
"""

import shutil
import os
import argparse
from pathlib import Path
import logging
import platform

try:
    import winreg
except ModuleNotFoundError:
    winreg = None  # type: ignore[assignment]


def _registry_search(release: str) -> Path | None:
    try:
        # must use "\" as path separator in Windows registry
        matlab_path = winreg.QueryValue(
            winreg.HKEY_LOCAL_MACHINE, rf"SOFTWARE\MathWorks\{release}\MATLAB"
        )

        return Path(matlab_path)
    except (AttributeError, OSError) as e:
        logging.debug(f"Registry key not found {e}, falling back to ProgramFiles search.")
        return None


def _windows_search(release: str) -> Path | None:
    """Look at Windows registry, Program Files, Path for Matlab installation."""

    if winreg is not None:
        if (p := _registry_search(release)) is not None and p.is_dir():
            logging.info(f"Using Matlab from registry: {p}")
            return p

    if (r := os.environ.get("ProgramFiles")) is not None:
        if (p := Path(r) / "MATLAB" / release / "bin/win64").is_dir():
            logging.info(f"Using Matlab from ProgramFiles: {p}")
            return p

    tail = "win64"

    if (r := shutil.which("matlab")) is not None:
        if (p := Path(r).resolve().parent / tail).is_dir():
            logging.info(f"Using Matlab from PATH: {p}")
            return p

    return None


def _macos_search(release: str) -> Path | None:
    """Search for Matlab in common macOS application directories."""

    arch = platform.machine()
    match (arch):
        case "x86_64":
            tail = "maci64"
        case "arm64":
            tail = "maca64"
        case _:
            raise SystemExit(f"ERROR: Unsupported architecture for macOS {arch}.")

    roots = ["~/Applications", "/Applications"]
    for root in roots:
        if (p := Path(root).expanduser() / f"MATLAB_{release}.app" / "bin" / tail).is_dir():
            return p

    if (r := shutil.which("matlab")) is not None:
        if (p := Path(r).resolve().parent / tail).is_dir():
            logging.info(f"Using Matlab from PATH: {p}")
            return p

    return None


def _linux_search(release: str) -> Path | None:

    tail = "glnxa64"

    if (r := shutil.which("matlab")) is not None:
        if (p := Path(r).resolve().parent / tail).is_dir():
            logging.info(f"Using Matlab from PATH: {p}")
            return p

    return None


def find_activate_matlab(release: str) -> str | None:
    """
    Fallback to PATH if the platform-specific search fails.
    Linux doesn't have a platform-specific search.
    """
    name = "MathWorksProductAuthorizer"

    mr = None

    match (os.name):
        case "nt":
            mr = _windows_search(release)
        case "darwin":
            mr = _macos_search(release)
        case _:
            mr = _linux_search(release)

    return shutil.which(name, path=mr)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Find the MathWorksProductAuthorizer executable.")
    parser.add_argument(
        "release",
        type=str,
        help="Specify the MATLAB version to search for (e.g., R2023a)",
        default=None,
    )
    parser.add_argument("-v", "--verbose", action="store_true", help="Enable verbose output")
    args = parser.parse_args()

    if args.verbose:
        logging.basicConfig(level=logging.DEBUG)

    exe = find_activate_matlab(args.release)

    print("This program can reactivate the Matlab license if authorized:\n")
    print(exe)
