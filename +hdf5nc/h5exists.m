function exists = h5exists(filename, varnames)
% check if variable(s) exists in HDF5 file
%
% filename: HDF5 filename
% varname: name of variable inside HDF5 file
%
% exists: boolean (scalar or vector)

arguments
  filename (1,1) string
  varnames (1,:) string
end

import hdf5nc.h5variables

i = startsWith(varnames, "/");
varnames(i) = extractAfter(varnames(i), 1);
% NOT contains because we want exact string match
exists = ismember(varnames, h5variables(filename));

end % function
