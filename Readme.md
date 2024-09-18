# Standard library for Matlab

[![DOI](https://zenodo.org/badge/273830124.svg)](https://zenodo.org/badge/latestdoi/273830124)
[![View matlab-hdf5 on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/78673-matlab-hdf5)
[![MATLAB on GitHub-Hosted Runner](https://github.com/geospace-code/matlab-hdf5/actions/workflows/ci.yml/badge.svg)](https://github.com/geospace-code/matlab-hdf5/actions/workflows/ci.yml)

Matlab users coming from other languages often notice the missing functionality contained within this user-developed, unofficial "stdlib" for Matlab.
These system, filesystem, and HDF5 / HDF4 / NetCDF functions are useful across several of our own and others projects.

The absolute minimum Matlab release is R2021a.

Self-tests can be run from that matlab-stdlib/ directory:

```matlab
buildtool
```

[API Documentation](https://geospace-code.github.io/matlab-stdlib)

## Java details

The "matlab-stdlib" package uses Java functions throughout, with the higher-level
[java.nio.Files](https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/Files.html)
and the classic
[java.io.File](https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/io/File.html) classes.

That is, if Matlab was started with
[-nojvm](https://www.mathworks.com/help/matlab/matlab_env/commonly-used-startup-options.html),
many of the stdlib filesystem function do not work.

Get the JVM version with

```matlab
version("-java")
```

The Matlab default
[JVM can be configured](https://www.mathworks.com/help/matlab/matlab_external/configure-your-system-to-use-java.html)
to
[compatible JRE](https://www.mathworks.com/support/requirements/language-interfaces.html)
across
[Matlab versions](https://www.mathworks.com/support/requirements/openjdk.html)
by using the
[jenv](https://www.mathworks.com/help/matlab/ref/jenv.html)
Matlab function.

Matlab-stdlib has been test with JVM from version 8 to 17.

## Acknowledgements

Stdlib for Matlab was partly funded by NASA NNH19ZDA001N-HDEE grant 80NSSC20K0176.
