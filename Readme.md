# Matlab stdlib API

The API is broken up into modules:

* stdlib.fileio
* stdlib.hdf5nc
* stdlib.sys

## stdlib.fileio

These functions are in namespace:

```matlab
import stdlib.fileio.*
```

* [absolute_path](./absolute_path.html): returns absolute path if possible
* [expanduser](./expanduser.html): Expands tilde like Python pathlib.Path().expanduser()
* [posix](./posix.html)
* [samepath](./samepath.html)
* [which](./which.html): Find executable on Path, like Python shutil.which

## HDF5: stdlib.hdf5nc

Check HDF5 version built into Matlab:

```matlab
[major,minor,rel] = H5.get_libversion()
```

These functions are in namespace:

```matlab
import stdlib.hdf5nc.*
```

* [auto_chunk_size](./auto_chunk_size.html)
* [h5exists](./h5exists.html): Check that a dataset exists in file
* [h5ndims](./h5ndims.html): Get the dataset rank (number of dimensions)
* [h5size](./h5size.html): Get the dataset size (shape). A scalar dataset will return empty `[]`
* [h5variables](./h5variables.html): Get the names of all datasets in a file

---

[h5save](./h5save.html): Save a variable to an HDF5 dataset.
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


## NetCDF4: stdlib.hdf5nc

Check NetCDF4 version built into Matlab:

```matlab
netcdf.inqLibVers
```

These functions are in namespace:

```matlab
import stdlib.hdf5nc.*
```

* [ncexists](./ncexists.html): Check that a dataset exists in file
* [ncndims](./ncndims.html): Get the dataset rank (number of dimensions)
* [ncsize](./ncsize.html): Get the dataset size (shape). A scalar dataset will return empty `[]`
* [ncvariables](./ncvariables.html): Get the names of all datasets in a file

---

Save a variable to a dataset.
If dataset exists, the existing dataset shape must match the variable.

```matlab
ncsave(filename, variable_name, variable)
```

## system: stdlib.sys

* [checkRAM](./checkRAM.html)
* [has_wsl](./has_wsl.html)
* [isoctave](./isoctave.html)
* [iswsl](./iswsl.html)
* [subprocess_run](./subprocess_run.html): like Python subprocess.run, enables setting environment variables and working directory
* [winpath2wslpath](./winpath2wslpath.html)
* [wslpath2winpath](./wslpath2winpath.html)
* [wsl_tempfile](./wsl_tempfile.html)
