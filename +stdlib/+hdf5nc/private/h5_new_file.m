function h5_new_file(filename, varname, A, sizeA)

if isempty(sizeA)
  sizeA = defaultSize(A);
elseif all(sizeA > 0)
  assert(numel(A) == prod(sizeA), 'hdf5nc:h5save:shape_error', "dataset # of elements %d != prod(sizeA) %d", numel(A), prod(sizeA))
elseif ~isscalar(sizeA)
  error('hdf5nc:h5save:shape_error', "only scalar size may be 0")
end

if isscalar(sizeA)
  if sizeA == 0
    h5_write_scalar(filename, varname, A)
    return
  else
    h5create(filename, varname, sizeA, "Datatype", class(A))
  end
else
  create_compress(filename, varname, A, sizeA)
end

h5write(filename, varname, A)

end % function
