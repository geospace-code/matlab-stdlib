function fsize = ncsize(filename, varname)
% get size (shape) of a NetCDF4 variable
%
% filename: NetCDF4 filename
% variable: name of variable inside file
%
% fsize: vector of variable size per dimension
arguments
  filename (1,1) string
  varname (1,1) string
end

fsize = ncinfo(expanduser(filename), varname).Size;

end
