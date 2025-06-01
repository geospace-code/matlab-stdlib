%% NCEXISTS check if variable exists in NetCDF4 file
%
%%% Inputs
% * file: data filename
% * variable: path of variable in file
%%% Outputs
% * exists: boolean

function exists = ncexists(file, variable)
arguments
  file {mustBeTextScalar}
  variable {mustBeTextScalar}
end

exists = false;

try
  ncinfo(file, variable);
  exists = true;
catch e
  if ~strcmp(e.identifier, "MATLAB:imagesci:netcdf:badLocationString") && ...
     ~strcmp(e.identifier, "MATLAB:imagesci:netcdf:unknownLocation") && ...
     ~strcmp(e.message, "NetCDF: Variable not found")

    rethrow(e)
  end
end

end


%!test
%! if !isempty(pkg('list', 'netcdf'))
%! pkg load netcdf
%! fn = tempname();
%! ds = 'a';
%! nccreate(fn, ds)
%! assert(ncexists(fn, ds))
%! assert(!ncexists(fn, 'b'))
%! delete(fn)
%! endif
