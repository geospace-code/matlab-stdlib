%% NCVARIABLES get NetCDF dataset names
% get dataset names in a file under group
% default is datasets under "/", optionally under "/group"
%
%%% Inputs
% * file: filename
% * group: group name (optional)
%%% Outputs
% * names: variable names

function names = ncvariables(file, group)
arguments
  file (1,1) string {mustBeFile}
  group (1,1) string = ""
end


if stdlib.len(group) == 0
  finf = ncinfo(file);
else
  finf = ncinfo(file, group);
end

ds = finf.Variables(:);

if isempty(ds)
  names = [];
else
  names = {ds.Name};
end

try %#ok<TRYNC>
  names = string(names);
end


end


%!test
%! pkg load netcdf
%! fn = tempname();
%! ds = 'a';
%! nccreate(fn, ds)
%! assert(ncvariables(fn, ''), {'a'})
%! delete(fn)
