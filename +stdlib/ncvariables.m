%% NCVARIABLES get NetCDF dataset names
% get dataset names in a file under group
% default is datasets under '/', optionally under '/group'
%
%%% Inputs
% * file: filename
% * group: group name (optional)
%%% Outputs
% * names: variable names

function names = ncvariables(file, group)
if nargin < 2
  group = '/';
end

finf = ncinfo(file, group);
ds = finf.Variables(:);

if isempty(ds)
  names = [];
else
  names = {ds.Name};
end

names = string(names);

end
