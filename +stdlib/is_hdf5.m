%% IS_HDF5 is file an HDF5 file?

function is_hdf5 = is_hdf5(filename)

is_hdf5 = H5F.is_hdf5(filename) == 1;

end
