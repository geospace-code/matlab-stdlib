function exists = ncexists(file, variable)
%% ncexists(file, variable)
% check if variable exists in NetCDF4 file
%
%%% Inputs
% * file: data filename
% * variable: path of variable in file
%
%%% Outputs
% * exists: boolean

arguments
  file (1,1) string
  variable string {mustBeScalarOrEmpty}
end

exists = stdlib.hdf5nc.ncexists(file, variable);

end
