%% H5VARIABLES get HDF5 dataset names
% get dataset names in a file under group
% default is datasets under "/", optionally under "/group"
%
%%% Inputs
% * file: filename
% * group: group name (optional)
%%% Outputs
% * names: variable names

function names = h5variables(file, group)
arguments
  file (1,1) string {mustBeFile}
  group (1,1) string = ""
end

if strlength(group) == 0
  finf = h5info(file);
else
  finf = h5info(file, group);
end

ds = finf.Datasets;

if isempty(ds)
  names = string.empty;
else
  names = string({ds.Name});
end

end
