%% NCSIZE get size (shape) of a NetCDF4 variable
% get size (shape) of a data file variable
%
%%% Inputs
% filename: data filename
% variable: name of variable inside file
%%% Outputs
% fsize: vector of variable size per dimension. Empty if scalar variable.

function fsize = ncsize(file, variable)
arguments
  file (1,1) string {mustBeFile}
  variable (1,1) string
end

dsi = ncinfo(file, variable);
if isempty(dsi.Dimensions)
  fsize = [];
else
  fsize = dsi.Size;
end

end

%!test
%! if !isempty(pkg('list', 'netcdf'))
%! pkg load netcdf
%! fn = tempname();
%! nccreate(fn, 'a')
%! assert(ncsize(fn, 'a'), [])
%! nccreate(fn, 'b', 'Dimensions', {'x', 2, 'y', 3})
%! assert(ncsize(fn, 'b'), [2, 3])
%! delete(fn)
%! endif
