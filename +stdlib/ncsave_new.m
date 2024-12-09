%% NCSAVE_NEW Save a variable to an new NetCDF4 dataset
% normally users will use ncsave() instead of this function

function ncsave_new(file, varname, A, sizeA, ncdims, compressLevel)

if isscalar(A)
  nccreate(file, varname, "Datatype", class(A), "Format", 'netcdf4')
elseif isvector(A) || ischar(A) || isstring(A)
  nccreate(file, varname, "Dimensions", ncdims, "Datatype", class(A), "Format", 'netcdf4')
elseif compressLevel
  % enable Gzip compression
  % Matlab's dim order is flipped from C / Python
  nccreate(file, varname, "Dimensions", ncdims, "Datatype", class(A), "Format", 'netcdf4', ...
    "DeflateLevel", compressLevel, "Shuffle", true, ...
    "ChunkSize", stdlib.auto_chunk_size(sizeA))
else
  nccreate(file, varname, "Dimensions", ncdims, "Datatype", class(A), "Format", 'netcdf4')
end

ncwrite(file, varname, A)

end

%!test
%! fn = 'test_ncsave_new.nc';
%! ds = 'a';
%! a = [1,2];
%! delete(fn)
%! ncsave_new(fn, ds, a, size(a), {"x", 1, "y", 2}, 0)
%! assert(ncread(fn, ds), a)
%! delete(fn)
