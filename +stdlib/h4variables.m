%% H4VARIABLES get HDF4 dataset names
% get dataset names in a file under group
% default is datasets under "/", optionally under "/group"
%
%%% Inputs
% * file: filename
% * group: group name (optional)
%%% Outputs
% * names: variable names

function names = h4variables(file)

finf = hdfinfo(file);

ds = finf.SDS;

names = string({ds.Name});

end
