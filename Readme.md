# Matlab HDF5 and NetCDF4 high-level functions

![ci](https://github.com/scivision/matlab-hdf5/workflows/ci/badge.svg)
[![DOI](https://zenodo.org/badge/273830124.svg)](https://zenodo.org/badge/latestdoi/273830124)
[![View matlab-hdf5 on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/78673-matlab-hdf5)

These HDF5 and NetCDF4 functions should be built into Matlab itself, but since they're not yet, we provide them.
The NetCDF4 functions also work with GNU Octave when
[octave-netcdf](https://octave.sourceforge.io/netcdf/index.html)
is installed.

## HDF5

This package is setup as a Matlab package, so we assume you have either:

```matlab
import hdf5nc.*
```

or append `hdf5nc.` to each function call.

Run selftests by:

```matlab
hdf5nc.tests.test_hdf5
hdf5nc.tests.test_netcdf
```

* Check that a dataset exists in file:

    ```matlab
    h5exists(filename, dataset_name)
    ```

* Save a variable to a dataset. If dataset exists, the existing dataset shape must match the variable.

    ```matlab
    h5save(filename, dataset_name, dataset)
    ```

* Get the dataset size (shape)

    ```matlab
    h5size(filename, dataset_name)
    ```

* Get the names of all datasets in a file

    ```matlab
    h5variables(filename)
    ```

## NetCDF4

* Check that a variable exists in file:

    ```matlab
    ncexists(filename, variable_name)
    ```

* Save a variable to a dataset. If dataset exists, the existing dataset shape must match the variable.

    ```matlab
    ncsave(filename, variable_name, variable)
    ```

* Get the dataset size (shape)

    ```matlab
    ncsize(filename, variable_name)
    ```

* Get the names of all datasets in a file

    ```matlab
    ncvariables(filename)
    ```

## General utilities

* Check if running on GNU Octave

    ```matlab
    isoctave()
    ```

* expand a leading tilde to the current user home directory

    ```matlab
    expanduser(path)
    ```

## unit tests

The files
[test_hdf5.m](./test_hdf5.m)
and
[test_netcdf.m](./test_netcdf.m)
are meant to be each run serially.
That is, if using Matlab
[runtests](https://www.mathworks.com/help/matlab/ref/runtests.html)
don't use
['UseParallel', true](https://www.mathworks.com/help/parallel-computing/run-matlab-functions-with-automatic-parallel-support.html).
