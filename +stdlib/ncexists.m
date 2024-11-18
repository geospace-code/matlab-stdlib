%% NCEXISTS check if variable exists in NetCDF4 file
%
%%% Inputs
% * file: data filename
% * variable: path of variable in file
%%% Outputs
% * exists: boolean

function exists = ncexists(file, variable)
arguments
  file (1,1) string {mustBeFile}
  variable (1,1) string
end

exists = false;

try
  ncinfo(file, variable);
  exists = true;
catch e
  if ~any(contains(e.identifier, ["MATLAB:imagesci:netcdf:badLocationString", "MATLAB:imagesci:netcdf:unknownLocation"]))
    rethrow(e)
  end
end

end
