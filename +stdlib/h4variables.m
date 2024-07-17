function names = h4variables(file)
%% h4variables(file, group)
% get dataset names in a file under group
% default is datasets under "/", optionally under "/group"
%
%%% Inputs
% * file: filename
% * group: group name (optional)
%
%%% Outputs
% * names: variable names
arguments
  file (1,1) string {mustBeFile}
end

finf = hdfinfo(file);

ds = finf.SDS;

names = string({ds.Name});

end
