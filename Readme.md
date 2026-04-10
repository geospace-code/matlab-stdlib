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

For the functions compatible with GNU Octave, from the matlab-stdlib/ directory:

```octave
addpath(pwd)
oruntests('+stdlib/')
```

## External language backends

Our functions that aren't possible in native Matlab code are implemented using Matlab's no-compile
[external language interfaces](https://www.mathworks.com/support/requirements/language-interfaces.html).
The
[API listing](https://geospace-code.github.io/matlab-stdlib/)
"backend" column tells which functions have selectable backend implementations.
By default, when the "backend" is not specified to a function having selectable backend, the algorithm searches for the first available backend and uses that.

Matlab external backends include:

* [Java](./Readme_java.md): all supported Matlab releases
* [Perl](https://www.mathworks.com/help/matlab/ref/perl.html):  Matlab R2018a and newer. This uses a system() call to Perl.
* [Python](https://www.mathworks.com/help/matlab/call-python-libraries.html): Matlab R2022b and newer. `stdlib.has_python` checks that the Python version set by `pyenv()` is compatible with the Matlab release. If there is a problem with Python on a particular Matlab install, `stdlib.has_python(false)` disables the Python backend for that Matlab session.
* System shell calls: all supported Matlab releases. As a backup when the platform doesn't have the primary (faster) methods available, the system shell can be called for some functions.
* .NET as described below.

### .NET from Matlab

[.NET](https://www.mathworks.com/help/matlab/call-net-from-matlab.html)
support in MATLAB when a compatible
[.NET SDK is installed](https://www.scivision.dev/matlab-dotnet-linux-macos)
includes:

* Windows: all supported Matlab releases, installed from `winget search Microsoft.DotNet.SDK`
* Linux or macOS: R2024b and newer

For macOS, `brew install dotnet` and then in Matlab `edit(fullfile(userpath, 'startup.m'))` and add the line `setenv('DOTNET_ROOT', '/opt/homebrew/opt/dotnet/libexec')` where the path is determined from `brew --prefix dotnet`.

## Acknowledgments

Stdlib for Matlab was partly funded by NASA NNH19ZDA001N-HDEE grant 80NSSC20K0176.

## Relevant Matlab / GNU Octave projects

* [Matlab or GNU Octave HDF5 interface](https://www.mathworks.com/matlabcentral/fileexchange/180491-easyh5-a-tiny-hdf5-reader-writer-for-matlab-octave)
* [GNU Octave hdf5oct package](https://gnu-octave.github.io/packages/hdf5oct/)
* [GNU Octave netcdf package](https://gnu-octave.github.io/packages/netcdf/)
