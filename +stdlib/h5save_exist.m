%% H5SAVE_EXIST write data to existing HDF5 dataset
% normally users use h5save() instead of this function

function h5save_exist(filename, varname, A, sizeA)

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

%!test
%! if !isempty(pkg('list', 'hdf5oct'))
%! pkg load hdf5oct
%! fn = tempname();
%! ds = '/a';
%! a = [1,2];
%! b = [3,4];
%! h5save_new(fn, ds, a, size(a), 0)
%! h5save_exist(fn, ds, b, size(b))
%! assert(h5read(fn, ds), b)
%! delete(fn)
%! endif
