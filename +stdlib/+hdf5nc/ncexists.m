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
  file (1,1) string {mustBeNonzeroLengthText}
  varnames (1,:) string {mustBeNonempty,mustBeNonzeroLengthText}
end

import stdlib.hdf5nc.ncvariables

% NOT contains because we want exact string match
exists = ismember(varnames, ncvariables(file));

end % function
