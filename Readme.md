# Standard library for Matlab

[![DOI](https://zenodo.org/badge/273830124.svg)](https://zenodo.org/badge/latestdoi/273830124)
[![View stdlib for Matlab on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/78673-stdlib-for-matlab)
[![ci](https://github.com/geospace-code/matlab-stdlib/actions/workflows/ci.yml/badge.svg)](https://github.com/geospace-code/matlab-stdlib/actions/workflows/ci.yml)
[![ci-nojvm](https://github.com/geospace-code/matlab-stdlib/actions/workflows/ci-nojvm.yml/badge.svg)](https://github.com/geospace-code/matlab-stdlib/actions/workflows/ci-nojvm.yml)

Matlab users coming from other languages often notice the missing functionality contained within this user-developed, unofficial "stdlib" for Matlab.
These system, filesystem, and HDF5 / HDF4 / NetCDF functions are useful across several of our own and others projects.

The absolute minimum Matlab release is R2021a.

Self-tests can be run from that matlab-stdlib/ directory:

```matlab
buildtool
```

[API Documentation](https://geospace-code.github.io/matlab-stdlib)

Many Matlab-Stdlib functions use the factory JRE in Matlab, and have been tested with JVM versions 8 and 17.
For reference, we further
[discuss Java implementation details](./Readme_java.md).
If Matlab was started with
[-nojvm](https://www.mathworks.com/help/matlab/matlab_env/commonly-used-startup-options.html),
some Matlab-stdlib functions do not work.
We have a CI job that tests without JVM.



## Acknowledgments

Stdlib for Matlab was partly funded by NASA NNH19ZDA001N-HDEE grant 80NSSC20K0176.
