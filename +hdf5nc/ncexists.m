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

exists = contains(varnames, hdf5nc.ncvariables(filename));

end % function
