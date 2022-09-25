function exists = h5exists(file, vars)
% check if object(s) exists in HDF5 file
%
% parameters
% ----------
% file: HDF5 filename
% varname: path(s) of variable in file
%
% returns
% -------
% exists: boolean (scalar or vector)

arguments
  file (1,1) string {mustBeFile}
  vars (1,:) string {mustBeNonempty,mustBeNonzeroLengthText}
end

i = startsWith(vars, "/");
vars(i) = extractAfter(vars(i), 1);
% NOT contains because we want exact string match
exists = ismember(vars, stdlib.hdf5nc.h5variables(file));

end % function
