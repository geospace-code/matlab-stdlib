function exists = h5exists(filename, varnames)
% check if variable(s) exists in HDF5 file
%
% filename: HDF5 filename
% varname: name of variable inside HDF5 file
%
% exists: boolean
arguments
  filename (1,1) string
  varnames (1,:) string
end

if startsWith(varnames, "/")
  varnames = extractAfter(varnames, 1);
end

vars = hdf5nc.h5variables(filename);

exists = false(size(varnames));
for i = 1:length(varnames)
  exists(i) = any(vars == varnames(i));
end

end % function
