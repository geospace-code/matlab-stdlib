# Standard library for Matlab

[![DOI](https://zenodo.org/badge/273830124.svg)](https://zenodo.org/badge/latestdoi/273830124)
[![View stdlib for Matlab on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/78673-stdlib-for-matlab)
[![ci](https://github.com/geospace-code/matlab-stdlib/actions/workflows/ci.yml/badge.svg)](https://github.com/geospace-code/matlab-stdlib/actions/workflows/ci.yml)
[![ci-nojvm](https://github.com/geospace-code/matlab-stdlib/actions/workflows/ci-nojvm.yml/badge.svg)](https://github.com/geospace-code/matlab-stdlib/actions/workflows/ci-nojvm.yml)

Matlab users coming from other languages will benefit from the functionality contained within this user-developed, unofficial "stdlib" standard library of functions.
These system, filesystem, and HDF5 / HDF4 / NetCDF functions are used by numerous independent projects.

Matlab R2019b is the minimum version required due to use of
[function argument validation](https://www.mathworks.com/help/matlab/ref/arguments.html).
Full functionality is available with:

* Linux: Matlab R2019b and newer
* macOS, Windows: Matlab R2020b and newer

## Self-tests

The self-tests can be run from the top matlab-stdlib/ directory.

Matlab R2022b and newer:

```matlab
buildtool test
```

Matlab older than R2022b:

```matlab
test_main
```

## External language backends

Our functions that aren't possible in native Matlab code are implemented using Matlab's no-compile
[external language interfaces](https://www.mathworks.com/support/requirements/language-interfaces.html).
The
[API listing](https://geospace-code.github.io/matlab-stdlib/)
"backend" column tells which functions have selectable backend implementations.
By default, when the "backend" is not specified to a function having selectable backend, the algorithm searches for the first available backend and uses that.
The user can specify the backend as listed in the API for those functions by specifying say "java" etc. as available per-function.
Normally the user will not specify the backend as we prioritize faster backends.

* [.NET](https://www.mathworks.com/help/matlab/call-net-from-matlab.html)
  * Windows: all supported Matlab releases
  * Linux / macOS: R2024b and newer
* [Java](https://www.mathworks.com/help/matlab/using-java-libraries-in-matlab.html): all supported Matlab releases. A few Java functions are Linux / macOS only, but have other backends available.
* [Python](https://www.mathworks.com/help/matlab/call-python-libraries.html): Matlab R2022b and newer
* System shell calls: all supported Matlab releases. As a backup when the platform doesn't have the primary (faster) methods available, the system shell can be called for some functions.

## Acknowledgments

Stdlib for Matlab was partly funded by NASA NNH19ZDA001N-HDEE grant 80NSSC20K0176.
