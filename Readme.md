# Matlab standard library

[![DOI](https://zenodo.org/badge/273830124.svg)](https://zenodo.org/badge/latestdoi/273830124)
[![View matlab-hdf5 on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/78673-matlab-hdf5)
[![MATLAB on GitHub-Hosted Runner](https://github.com/geospace-code/matlab-hdf5/actions/workflows/ci.yml/badge.svg)](https://github.com/geospace-code/matlab-hdf5/actions/workflows/ci.yml)

Matlab users coming from other languages often notice the missing functionality contained within this user-developed, unofficial "stdlib" for Matlab.
These system "sys", file I/O "fileio" and HDF5/NetCDF "hdf5nc" function are useful across several of our own and others projects.

The absolute minimum Matlab release is R2019b.

* HDF5 full features (string, scalar dataspace) requires Matlab >= R2020a
* NetCDF4 string support requires Matlab >= R2021b

Self-tests can be run from that matlab-stdlib/ directory:

```matlab
buildtool
```

[API Documentation](./docs)
