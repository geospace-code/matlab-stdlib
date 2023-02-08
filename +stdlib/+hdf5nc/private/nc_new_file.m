function nc_new_file(filename, varname, A, sizeA, ncdims)

if isscalar(A)
  nccreate(filename, varname, ...
      "Datatype", class(A), ...
      "Format", 'netcdf4')
elseif isvector(A)
  nccreate(filename, varname, ...
      "Dimensions", ncdims, ...
      "Datatype", class(A), ...
      "Format", 'netcdf4')
else
  % enable Gzip compression--remember Matlab's dim order is flipped from
  % C / Python
  nccreate(filename, varname, ...
    "Dimensions", ncdims, ...
    "Datatype", class(A), ...
    "DeflateLevel", 1, "Shuffle", true, ...
    "ChunkSize", stdlib.hdf5nc.auto_chunk_size(sizeA), ...
    "Format", 'netcdf4')
end

ncwrite(filename, varname, A)

end % function
