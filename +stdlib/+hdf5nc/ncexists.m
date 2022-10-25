function exists = ncexists(file, vars)
%% ncexists(file, vars)
% check if variable(s) exists in NetCDF4 file
%
%%% Inputs
% * file: data filename
% * varname: path(s) of variable in file
%
%%% Outputs
% * exists: boolean (scalar or vector)

arguments
  file (1,1) string {mustBeFile}
  vars (1,:) string {mustBeNonempty,mustBeNonzeroLengthText}
end

% NOT contains because we want exact string match
exists = ismember(vars, stdlib.hdf5nc.ncvariables(file));

end % function
