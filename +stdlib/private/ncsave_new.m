%% NCSAVE_NEW Save a variable to an new NetCDF4 dataset
% normally users will use ncsave() instead of this function

function ncsave_new(file, varname, A, sizeA, ncdims, compressLevel)
arguments
  file
  varname
  A
  sizeA (1,:) double {mustBeInteger,mustBeNonnegative} = []
  ncdims (1,:) cell = {}
  compressLevel (1,1) double {mustBeInteger,mustBeNonnegative} = 0
end

if isscalar(A)
  nccreate(file, varname, 'Datatype', class(A), 'Format', 'netcdf4')
elseif isvector(A) || ischar(A) || isstring(A)
  nccreate(file, varname, 'Dimensions', ncdims, ...
    'Datatype', class(A), 'Format', 'netcdf4')
elseif compressLevel
  % enable Gzip compression
  % Matlab's dim order is flipped from C / Python
  nccreate(file, varname, 'Dimensions', ncdims, ...
    'Datatype', class(A), 'Format', 'netcdf4', ...
    'DeflateLevel', compressLevel, 'Shuffle', true, ...
    'ChunkSize', stdlib.auto_chunk_size(sizeA))
else
  nccreate(file, varname, 'Dimensions', ncdims, ...
    'Datatype', class(A), 'Format', 'netcdf4')
end

ncwrite(file, varname, A)

end
