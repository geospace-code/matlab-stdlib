function exists = h5exists(file, vars)
%% H5EXISTS(file, vars)
% check if object(s) exists in HDF5 file
%
%%% Inputs
% * file: data filename
% * varname: path(s) of variable in file
%
%%% Outputs
% * exists: boolean (scalar or vector)

arguments
  file (1,1) string {mustBeFile}
  vars string
end

i = startsWith(vars, "/");
vars(i) = extractAfter(vars(i), 1);
% NOT contains because we want exact string match
exists = ismember(vars, stdlib.hdf5nc.h5variables(file));

end % function
