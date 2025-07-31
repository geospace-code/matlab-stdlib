%% H5SAVE_EXIST write data to existing HDF5 dataset
% normally users use h5save() instead of this function

function h5save_exist(filename, varname, A, sizeA)
arguments
  filename {mustBeTextScalar}
  varname {mustBeTextScalar}
  A {mustBeNonempty}
  sizeA (1,:) double {mustBeInteger,mustBeNonnegative} = []
end

diskshape = stdlib.h5size(filename, varname);
if length(diskshape) >= 2
  % start is always a row vector, regardless of shape of array
  start = ones(1, ndims(A));
elseif ~isempty(diskshape)
  start = 1;
end

if isempty(sizeA)
  sizeA = defaultSize(A);
elseif all(sizeA > 0)
  assert(numel(A) == prod(sizeA), 'h5save:shape_error', "dataset # of elements %d != prod(sizeA) %d", numel(A), prod(sizeA))
elseif ~isscalar(sizeA)
  error('h5save:shape_error', "only scalar size may be 0")
end

if isscalar(A)
  h5write(filename, varname, A)
elseif all(diskshape == sizeA)
  h5write(filename, varname, A, start, sizeA)
elseif all(diskshape == fliplr(sizeA))
  h5write(filename, varname, A.', start, fliplr(sizeA))
else
  error('h5save:value_error', ['shape of ',varname,': ', int2str(sizeA), ' does not match existing HDF5 shape ', int2str(diskshape)])
end

end
