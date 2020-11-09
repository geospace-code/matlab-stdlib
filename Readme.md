# Matlab HDF5 and NetCDF4 high-level functions

[![DOI](https://zenodo.org/badge/273830124.svg)](https://zenodo.org/badge/latestdoi/273830124)
[![View matlab-hdf5 on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/78673-matlab-hdf5)
[![Build Status](https://dev.azure.com/mhirsch0512/matlab-hdf5/_apis/build/status/geospace-code.matlab-hdf5?branchName=master)](https://dev.azure.com/mhirsch0512/matlab-hdf5/_build/latest?definitionId=18&branchName=master)

These HDF5 and NetCDF4 functions should be built into Matlab itself, but since they're not yet, we provide them.

## Usage

This package is a Matlab package, so we assume you have either:

```matlab
import hdf5nc.*
```

or append `hdf5nc.` to each function call.

Run selftests by:

```matlab
runtests('hdf5nc')
```

### HDF5

Matlab R2020b uses HDF5 1.8.12.

```matlab
[major,minor,rel] = H5.get_libversion()
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

### NetCDF4

Matlab R2020b uses NetCDF4 4.7.3.

```matlab
netcdf.inqLibVers
```

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
