function h5_exist_file(filename, varname, A, sizeA)

import stdlib.hdf5nc.h5size

diskshape = h5size(filename, varname);
if length(diskshape) >= 2
  % start is always a row vector, regardless of shape of array
  start = ones(1,ndims(A));
elseif ~isempty(diskshape)
  start = 1;
end

if isempty(sizeA)
  sizeA = defaultSize(A);
end

if isscalar(A)
  h5write(filename, varname, A)
elseif all(diskshape == sizeA)
  h5write(filename, varname, A, start, "count", sizeA)
elseif all(diskshape == fliplr(sizeA))
  h5write(filename, varname, A.', start, "count", fliplr(sizeA))
else
  error('hdf5nc:h5save:value_error', ['shape of ',varname,': ', int2str(sizeA), ' does not match existing HDF5 shape ', int2str(diskshape)])
end

end % function
