# Matlab HDF5 and NetCDF4 high-level functions

![ci](https://github.com/scivision/matlab-hdf5/workflows/ci/badge.svg)

These functions are sorely needed in Matlab itself.
The NetCDF4 functions also work with GNU Octave when octave-netcdf is installed.

## hdf5

* Check that a dataset exists in file:

    ```matlab
    h5exists(filename, dataset_name)
    ```

* Save a varable to a dataset. If dataset exists, the existing dataset shape must match the variable.

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

### netcdf

* Check that a variable exists in file:

    ```matlab
    ncexists(filename, variable_name)
    ```

* Save a varable to a dataset. If dataset exists, the existing dataset shape must match the variable.

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
