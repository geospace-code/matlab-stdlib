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

import hdf5nc.expanduser

vinf = ncinfo(expanduser(filename), varname);
fsize = vinf.Size;

% Octave compatibility
if isempty(fsize)
  fsize = 1;
end

end
