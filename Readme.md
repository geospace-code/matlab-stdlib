# Standard library for Matlab

[![DOI](https://zenodo.org/badge/273830124.svg)](https://zenodo.org/badge/latestdoi/273830124)
[![View stdlib for Matlab on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/78673-stdlib-for-matlab)
[![ci](https://github.com/geospace-code/matlab-stdlib/actions/workflows/ci.yml/badge.svg)](https://github.com/geospace-code/matlab-stdlib/actions/workflows/ci.yml)
[![ci-nojvm](https://github.com/geospace-code/matlab-stdlib/actions/workflows/ci-nojvm.yml/badge.svg)](https://github.com/geospace-code/matlab-stdlib/actions/workflows/ci-nojvm.yml)

Matlab or GNU Octave users coming from other languages often notice the missing functionality contained within this user-developed, unofficial "stdlib" standard library of functions for users of Matlab or GNU Octave.
These system, filesystem, and HDF5 / HDF4 / NetCDF functions are useful across several of our own and others projects.

Matlab &ge; R2021a has full functionality.
Matlab R2019b is the minimum required due to use of
[arguments](https://www.mathworks.com/help/matlab/ref/arguments.html) syntax.
If using GNU Octave, the minimum version is 6.0.

Self-tests can be run from that matlab-stdlib/ directory:

```matlab
buildtool
```

[API Documentation](https://geospace-code.github.io/matlab-stdlib)

Many Matlab-Stdlib functions use the factory JRE in Matlab or GNU Octave, and have been tested with JVM versions 8 and 17 and newer.
Most Matlab-stdlib filesystem functions do not require Java.
For reference, we further
[discuss Java implementation details](./Readme_java.md).

If Matlab was started with
[-nojvm](https://www.mathworks.com/help/matlab/matlab_env/commonly-used-startup-options.html)
or GNU Octave started without Java,
most Matlab-stdlib functions still work.
This [CI job](https://github.com/geospace-code/matlab-stdlib/actions/workflows/ci-nojvm.yml)
tests without Java.

## GNU Octave

For HDF5 h5*() functions, install
[hdf5oct](https://gnu-octave.github.io/packages/hdf5oct/)
package from Octave prompt:

```octave
pkg install -forge hdf5oct
```

For NetCDF4 nc*() functions, install
[netcdf](https://gnu-octave.github.io/packages/netcdf/)
package from Octave prompt:

```octave
pkg install -forge netcdf
```


## Acknowledgments

Stdlib for Matlab was partly funded by NASA NNH19ZDA001N-HDEE grant 80NSSC20K0176.
