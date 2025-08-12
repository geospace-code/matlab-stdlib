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
  file
  group (1,1) string = ""
end


if stdlib.strempty(group)
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

names = string(names);

end
