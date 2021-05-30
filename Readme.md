# Matlab standard library

[![DOI](https://zenodo.org/badge/273830124.svg)](https://zenodo.org/badge/latestdoi/273830124)
[![View matlab-hdf5 on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/78673-matlab-hdf5)
[![MATLAB on GitHub-Hosted Runner](https://github.com/geospace-code/matlab-hdf5/actions/workflows/ci_matlab.yml/badge.svg)](https://github.com/geospace-code/matlab-hdf5/actions/workflows/ci_matlab.yml)

Matlab users coming from other languages often notice the missing functionality contained within this user-developed, unofficial "stdlib" for Matlab.
These system "sys", file I/O "fileio" and HDF5/NetCDF "hdf5nc" function are useful across several of our own and others projects.

## Usage

This package is a Matlab package, so we assume you have done like:

```matlab
import stdlib.hdf5nc.*
import stdlib.fileio.*
import stdlib.sys.*
```

or use the full package name like `stdlib.fileio.expanduser()`

Selftests can be run from that matlab-stdlib/ directory:

```matlab
TestAll
```

### HDF5

```matlab
import stdlib.hdf5nc.*
```


Matlab R2021a uses HDF5 1.8.12.

```matlab
[major,minor,rel] = H5.get_libversion()
```

Check that a dataset exists in file:

```matlab
h5exists(filename, dataset_name)
```

Save a variable to a dataset.
If dataset exists, the existing dataset shape must match the variable.

```matlab
h5save(filename, dataset_name, dataset)
```

Get the dataset size (shape)

```matlab
h5size(filename, dataset_name)
```

Get the names of all datasets in a file

```matlab
h5variables(filename)
```

### NetCDF4

```matlab
import stdlib.hdf5nc.*
```


Matlab R2021a uses NetCDF4 4.7.3.

```matlab
netcdf.inqLibVers
```

Check that a variable exists in file:

```matlab
ncexists(filename, variable_name)
```

Save a variable to a dataset.
If dataset exists, the existing dataset shape must match the variable.

```matlab
ncsave(filename, variable_name, variable)
```

Get the dataset size (shape)

```matlab
ncsize(filename, variable_name)
```

Get the names of all datasets in a file

```matlab
ncvariables(filename)
```
