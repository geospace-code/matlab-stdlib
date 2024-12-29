%% H5SAVE_NEW Save a variable to an new HDF5 dataset
% normally users will use h5save() instead of this function

function h5save_new(filename, varname, A, sizeA, compressLevel)

if isempty(sizeA)
  sizeA = defaultSize(A);
elseif all(sizeA > 0)
  assert(numel(A) == prod(sizeA), 'h5save:shape_error', "dataset # of elements %d != prod(sizeA) %d", numel(A), prod(sizeA))
elseif ~isscalar(sizeA)
  error('h5save:shape_error', "only scalar size may be 0")
end

if isscalar(sizeA)
  if sizeA == 0
    h5save_scalar(filename, varname, A)
    return
  else
    h5create(filename, varname, sizeA, "Datatype", class(A))
  end
elseif ~compressLevel || stdlib.isoctave()
  h5create(filename, varname, sizeA, "Datatype", class(A))
else
  h5create(filename, varname, sizeA, "Datatype", class(A), "Fletcher32", true, "Shuffle", true, ...
      "Chunksize", stdlib.auto_chunk_size(sizeA), ...
      "Deflate", compressLevel)
end

h5write(filename, varname, A)

end

%!test
%! if !isempty(pkg('list', 'hdf5oct'))
%! pkg load hdf5oct
%! fn = tempname();
%! ds = '/a';
%! a = [1,2];
%! h5save_new(fn, ds, a, size(a), 0)
%! assert(h5read(fn, ds), a)
%! delete(fn)
%! endif
