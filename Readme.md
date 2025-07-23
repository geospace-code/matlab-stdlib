# Standard library for Matlab

[![DOI](https://zenodo.org/badge/273830124.svg)](https://zenodo.org/badge/latestdoi/273830124)
[![View stdlib for Matlab on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/78673-stdlib-for-matlab)
[![ci](https://github.com/geospace-code/matlab-stdlib/actions/workflows/ci.yml/badge.svg)](https://github.com/geospace-code/matlab-stdlib/actions/workflows/ci.yml)
[![ci-nojvm](https://github.com/geospace-code/matlab-stdlib/actions/workflows/ci-nojvm.yml/badge.svg)](https://github.com/geospace-code/matlab-stdlib/actions/workflows/ci-nojvm.yml)

Matlab or
[GNU Octave](./Readme_octave.md)
users coming from other languages will benefit from the functionality contained within this user-developed, unofficial "stdlib" standard library of functions.
These system, filesystem, and HDF5 / HDF4 / NetCDF functions are used across numerous projects.

Matlab R2019b is the minimum required due to use of
[arguments](https://www.mathworks.com/help/matlab/ref/arguments.html)
syntax.
URLs (e.g. https://, s3:// and similar) are treated as not existing.
The self-tests require at least Matlab R2021a and can be run from the matlab-stdlib/ directory.

```matlab
%% Matlab >= R2023a
buildtool test
```

```matlab
%% Matlab >= R2021b
run('test/test_nomex.m')
```

Build the optional high-performance
[MEX](https://www.mathworks.com/help/matlab/cpp-mex-file-applications.html)
functions from the Matlab prompt in Matlab R2023a or newer:

```matlab
buildtool mex
```

If just building MEX functions for the first time, to ensure the MEX functions are used instead of the plain Matlab script, one-time type `clear functions` in Matlab.

## Java-based functions

Most Matlab-stdlib filesystem functions work without the
[Java interface](./Readme_java.md).
If Matlab was started without Java using
[-nojvm](https://www.mathworks.com/help/matlab/matlab_env/commonly-used-startup-options.html),
most Matlab-stdlib functions still work.
This
[CI job](https://github.com/geospace-code/matlab-stdlib/actions/workflows/ci-nojvm.yml)
tests without Java.

## Acknowledgments

Stdlib for Matlab was partly funded by NASA NNH19ZDA001N-HDEE grant 80NSSC20K0176.
