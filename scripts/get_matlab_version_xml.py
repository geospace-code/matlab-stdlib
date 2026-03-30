"""
get Matlab version by parsing VersionInfo.xml
This file is present back to at least Matlab R2016a
This is much faster than running `matlab -batch "disp(version)"` and parsing the output,
which can take several to tens of seconds to start up Matlab.
"""

import argparse
import xml.etree.ElementTree as ET
import shutil
from pathlib import Path


def get_matlab_root() -> Path:
    ml = shutil.which("matlab")
    if ml is None:
        raise FileNotFoundError("MATLAB executable not found in PATH.")

    return Path(ml).parents[1]


def get_matlab_version(root: Path) -> str:
    if not root.is_dir():
        raise NotADirectoryError(f"{root} is not a valid directory.")

    xmlPath = root / "VersionInfo.xml"
    if not xmlPath.is_file():
        raise FileNotFoundError(xmlPath)

    tree = ET.parse(xmlPath)
    xroot = tree.getroot()

    v = xroot.find("version")

    return v.text.strip() if v is not None and v.text is not None else "Unknown version"


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Get MATLAB version from VersionInfo.xml"
    )
    parser.add_argument("matlab_root", nargs="?", help="Path to MATLAB root directory")
    args = parser.parse_args()

    root = Path(args.matlab_root) if args.matlab_root else get_matlab_root()

    print(get_matlab_version(root))
