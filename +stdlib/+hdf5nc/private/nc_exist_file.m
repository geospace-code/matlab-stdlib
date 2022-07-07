function nc_exist_file(filename, varname, A, sizeA)

import stdlib.hdf5nc.ncsize

diskshape = ncsize(filename, varname);

if all(diskshape == sizeA)
  ncwrite(filename, varname, A)
elseif all(diskshape == fliplr(sizeA))
  ncwrite(filename, varname, A.')
else
  error('hdf5nc:ncsave:value_error', ['shape of ',varname,': ', int2str(sizeA), ' does not match existing NetCDF4 shape ', int2str(diskshape)])
end

end % function
