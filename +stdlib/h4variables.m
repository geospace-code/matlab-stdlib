%% H4VARIABLES get HDF4 dataset names
% get dataset names in a file under group
% default is datasets under '/', optionally under '/group'
%
%%% Inputs
% * file: filename
% * group: group name (optional)
%%% Outputs
% * names: variable names

function names = h4variables(file)
arguments (Input)
  file {mustBeTextScalar,mustBeFile}
end
arguments (Output)
  names (1,:) string
end

finf = hdfinfo(file);

ds = finf.SDS;

names = {ds.Name};

end
