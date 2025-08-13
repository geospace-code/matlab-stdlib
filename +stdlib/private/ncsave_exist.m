%% NCSAVE_EXIST save a variable to a NetCDF4 existing dataset
% normally users will use ncsave() instead of this function

function ncsave_exist(filename, varname, A, sizeA)
arguments
  filename
  varname
  A
  sizeA (1,:) {mustBePositive, mustBeInteger}
end

diskshape = stdlib.ncsize(filename, varname);

if all(diskshape == sizeA)
  ncwrite(filename, varname, A)
elseif all(diskshape == fliplr(sizeA))
  ncwrite(filename, varname, A.')
else
  error('ncsave:value_error', ['shape of ',varname,': ', int2str(sizeA), ' does not match existing NetCDF4 shape ', int2str(diskshape)])
end

end
