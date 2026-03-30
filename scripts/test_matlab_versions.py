import pytest
import subprocess
import platform
from pathlib import Path

# these are HPC system specific
version_keys = [
    "2025b",
    "2025a",
    "2024b",
    "2024a",
    "2023b",
    "2023a",
    "2022b",
    "2022a",
    "2021b",
    "2021a",
    "2020b",
    "2020a",
    "2019b",
    "2019a",
    "2018b",
    "2018a",
    "2017b",
    "2017a",
]

R = Path(__file__).parents[1]


@pytest.mark.skipif(not platform.system() == "Linux", reason="HPC only")
@pytest.mark.parametrize("version", version_keys)
def test_matlab_version(version):

    ret = subprocess.run(
        f"module is-avail matlab/{version}", shell=True, capture_output=True, text=True
    )
    if ret.returncode != 0:
        pytest.skip(f"MATLAB version {version} not available {ret.stderr}")

    lcmd = f"module load matlab/{version} && "

    if version >= "2022b":
        cmd = lcmd + "matlab -batch 'buildtool test'"
    elif version >= "2019a":
        cmd = lcmd + "matlab -batch test_main"
    else:
        cmd = lcmd + "matlab -r 'test_main; exit'"

    subprocess.check_call(cmd, shell=True, cwd=R)
