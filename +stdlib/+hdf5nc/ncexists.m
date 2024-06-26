function exists = ncexists(file, variable)

arguments
  file (1,1) string {mustBeFile}
  variable string {mustBeScalarOrEmpty}
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
