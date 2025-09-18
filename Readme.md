# Standard library for Matlab

[![DOI](https://zenodo.org/badge/273830124.svg)](https://zenodo.org/badge/latestdoi/273830124)
[![View stdlib for Matlab on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/78673-stdlib-for-matlab)
[![ci](https://github.com/geospace-code/matlab-stdlib/actions/workflows/ci.yml/badge.svg)](https://github.com/geospace-code/matlab-stdlib/actions/workflows/ci.yml)

Matlab users coming from other languages will benefit from the functionality contained within this user-developed, unofficial "stdlib" standard library of functions.
These system, filesystem, and HDF5 / HDF4 / NetCDF functions are used by numerous independent projects.

## Self-tests

The self-tests can be run from the top matlab-stdlib/ directory.

Matlab R2022b and newer:

```matlab
buildtool test
```

Matlab R2017a and newer:

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
Normally the user does not specify the backend as we prioritize faster backends.

* [.NET](https://www.mathworks.com/help/matlab/call-net-from-matlab.html)
  * Windows: all supported Matlab releases
  * Linux / macOS: R2024b and newer
* [Java](./Readme_java.md): all supported Matlab releases
* [Perl](https://www.mathworks.com/help/matlab/ref/perl.html):  Matlab R2018a and newer. This uses a system() call to Perl, which is bundled with Matlab on Windows and generally available on Linux and macOS
* [Python](https://www.mathworks.com/help/matlab/call-python-libraries.html): Matlab R2022b and newer
* System shell calls: all supported Matlab releases. As a backup when the platform doesn't have the primary (faster) methods available, the system shell can be called for some functions.

## Acknowledgments

Stdlib for Matlab was partly funded by NASA NNH19ZDA001N-HDEE grant 80NSSC20K0176.
