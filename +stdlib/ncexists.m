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
  vars string
end

exists = stdlib.hdf5nc.ncexists(file, vars);

end
