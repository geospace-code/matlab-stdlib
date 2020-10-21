function fsize = ncsize(file, variable)
% get size (shape) of a NetCDF4 variable
%
% filename: NetCDF4 filename
% variable: name of variable inside file
%
% fsize: vector of variable size per dimension
arguments
  file (1,1) string
  variable (1,1) string
end

file = expanduser(file);
if ~isfile(file)
  error('hdf5nc:ncsize:fileNotFound', "%s does not exist", file)
end

fsize = ncinfo(file, variable).Size;

end
