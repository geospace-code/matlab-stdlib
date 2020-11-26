function exists = ncexists(file, varnames)
% check if variable(s) exists in NetCDF4 file
%
% parameters
% ----------
% file: NetCDF4 filename
% varname: name of variable inside file
%
% returns
% -------
% exists: boolean (scalar or vector)

arguments
  file string
  varnames (1,:) string
end

% NOT contains because we want exact string match
exists = ismember(varnames, hdf5nc.ncvariables(file));

end % function
