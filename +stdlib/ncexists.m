%% NCEXISTS check if variable exists in NetCDF4 file
%
%%% Inputs
% * file: data filename
% * variable: path of variable in file
%%% Outputs
% * exists: boolean

function exists = ncexists(file, variable)

try
  ncinfo(file, variable);
  exists = true;
catch e
  if e.identifier ~= "MATLAB:imagesci:netcdf:unknownLocation"
    rethrow(e)
  end

  exists = false;
end

end
