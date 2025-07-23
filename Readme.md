# Standard library for Matlab

[![DOI](https://zenodo.org/badge/273830124.svg)](https://zenodo.org/badge/latestdoi/273830124)
[![View stdlib for Matlab on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/78673-stdlib-for-matlab)
[![ci](https://github.com/geospace-code/matlab-stdlib/actions/workflows/ci.yml/badge.svg)](https://github.com/geospace-code/matlab-stdlib/actions/workflows/ci.yml)
[![ci-nojvm](https://github.com/geospace-code/matlab-stdlib/actions/workflows/ci-nojvm.yml/badge.svg)](https://github.com/geospace-code/matlab-stdlib/actions/workflows/ci-nojvm.yml)

Matlab or
[GNU Octave](./Readme_octave.md)
users coming from other languages will benefit from the functionality contained within this user-developed, unofficial "stdlib" standard library of functions.
These system, filesystem, and HDF5 / HDF4 / NetCDF functions are used across numerous projects.

Matlab R2020b is the minimum required due to use of
[arguments](https://www.mathworks.com/help/matlab/ref/arguments.html)
and
[mustBeTextScalar](https://www.mathworks.com/help/matlab/ref/mustbetextscalar.html)
syntax.
URLs (e.g. https://, s3:// and similar) are treated as not existing.

## Self-tests

The self-tests require at least Matlab R2020b and can be run from the matlab-stdlib/ directory.

Matlab R2024b and newer:

```matlab
buildtool test
```

Matlab R2023a..R2024a, inclusive:

```matlab
buildtool test_nomex
buildtool test_java
buildtool test_exe
buildtool test_mex
```

Matlab R2022b:

```matlab
buildtool test_nomex
buildtool test_java
```

Matlab older than R2022b:

```matlab
run('test/test_nomex.m')
```

## MEX functions

With Matlab R2023a and newer, optionally build high-performance
[MEX](https://www.mathworks.com/help/matlab/cpp-mex-file-applications.html)
functions (the same functions are provided by default without MEX) from the Matlab prompt in Matlab R2023a or newer:

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
