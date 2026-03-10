import pytest
import subprocess
import platform

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


@pytest.mark.skipif(not platform.system() == "Linux")
@pytest.mark.parametrize("version", version_keys)
def test_matlab_version(version):
    print(f"Testing MATLAB version: {version}")

    ret = subprocess.run(["module", "load", f"matlab/{version}"])
    if ret.returncode != 0:
        pytest.skip(f"MATLAB version {version} not available")

    if version >= "2022b":
        cmd = ["matlab", "-batch", "buildtool test"]
    elif version >= "2019a":
        cmd = ["matlab", "-batch", "test_main"]
    else:
        cmd = ["matlab", "-r", "test_main; exit"]

    subprocess.check_call(cmd)
