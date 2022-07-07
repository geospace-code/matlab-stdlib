function exists = h5exists(file, varnames)
% check if object(s) exists in HDF5 file
%
% parameters
% ----------
% file: HDF5 filename
% varname: name of variable in file
%
% returns
% -------
% exists: boolean (scalar or vector)

arguments
  file (1,1) string {mustBeNonzeroLengthText}
  varnames (1,:) string {mustBeNonempty,mustBeNonzeroLengthText}
end

import stdlib.hdf5nc.h5variables

i = startsWith(varnames, "/");
varnames(i) = extractAfter(varnames(i), 1);
% NOT contains because we want exact string match
exists = ismember(varnames, h5variables(file));

end % function
