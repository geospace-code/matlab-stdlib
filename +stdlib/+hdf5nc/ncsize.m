function fsize = ncsize(file, variable)
% get size (shape) of a NetCDF4 variable
%
% filename: NetCDF4 filename
% variable: name of variable inside file
%
% fsize: vector of variable size per dimension
arguments
  file (1,1) string {mustBeNonzeroLengthText}
  variable (1,1) string {mustBeNonzeroLengthText}
end

import stdlib.fileio.expanduser

file = expanduser(file);

assert(isfile(file), "%s not found", file)

fsize = ncinfo(file, variable).Size;

end
