function exists = ncexists(filename, varnames)
% check if variable(s) exists in NetCDF4 file
%
% filename: NetCDF4 filename
% varname: name of variable inside file
%
% exists: boolean
arguments
  filename (1,1) string
  varnames (1,:) string
end

vars = hdf5nc.ncvariables(filename);

exists = false(size(varnames));
for i = 1:length(varnames)
  exists(i) = any(vars == varnames(i));
end

end % function
