# GNU Octave with Matlab-stdlib

If using GNU Octave instead of Matlab the minimum Octave version is 7.0.

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

## C++ Oct files

Optionally, to enable higher-performance (faster) C++-based .oct functions, run the
[octave_build](./octave_build.m)
script from GNU Octave.
