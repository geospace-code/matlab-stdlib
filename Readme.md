# Matlab standard library

[![DOI](https://zenodo.org/badge/273830124.svg)](https://zenodo.org/badge/latestdoi/273830124)
[![View matlab-hdf5 on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/78673-matlab-hdf5)
[![MATLAB on GitHub-Hosted Runner](https://github.com/geospace-code/matlab-hdf5/actions/workflows/ci.yml/badge.svg)](https://github.com/geospace-code/matlab-hdf5/actions/workflows/ci.yml)

Matlab users coming from other languages often notice the missing functionality contained within this user-developed, unofficial "stdlib" for Matlab.
These system "sys", file I/O "fileio" and HDF5/NetCDF "hdf5nc" function are useful across several of our own and others projects.

Self-tests can be run from that matlab-stdlib/ directory:

```matlab
runtests('stdlib.tests')
```

## HDF5

```matlab
import stdlib.hdf5nc.*
```

Check HDF5 version built into Matlab:

```matlab
[major,minor,rel] = H5.get_libversion()
```

Check that a dataset exists in file:

```matlab
h5exists(filename, dataset_name)
```

---

Save a variable to a dataset.
If dataset exists, the existing dataset shape must match the variable.

```matlab
h5save(filename, dataset_name, dataset)
```

The shape of the dataset can be controlled by specifying the "size" argument.
This is particularly useful when writing HDF5 files to be used in other programming languages where dimensional shapes are important.
Matlab may collapse singleton dimensions otherwise.

```matlab
h5save(filename, dataset_name, dataset, size=[3,1])
```

Likewise, the type of the dataset may be explicitly specified with the "type" argument:

```matlab
h5save(filename, dataset_name, dataset, type="int32")
```

---

Get the dataset rank (number of dimensions)

```matlab
h5ndims(filename, variable_name)
```

---

Get the dataset size (shape)

```matlab
h5size(filename, dataset_name)
```

A scalar dataset will return empty `[]`.

---

Get the names of all datasets in a file

```matlab
h5variables(filename)
```

## NetCDF4

```matlab
import stdlib.hdf5nc.*
```

Check NetCDF4 version built into Matlab:

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

---

Get the variable rank (number of dimensions)

```matlab
ncndims(filename, variable_name)
```

---

Get the dataset size (shape)

```matlab
ncsize(filename, variable_name)
```

A scalar disk variable will return empty `[]`.

---

Get the names of all datasets in a file

```matlab
ncvariables(filename)
```
