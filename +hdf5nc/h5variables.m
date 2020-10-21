function [names, groups] = h5variables(file, group)
% get dataset names in a file
% Optionally, get first level of groups in a file.
%
% parameters
% ----------
% file: filename
% group: group name (optional)
%
% returns
% -------
% names: variable names
% groups: file groups

arguments
  file (1,1) string
  group string = string.empty
end

file = expanduser(file);
if ~isfile(file)
  error('hdf5nc:h5variables:fileNotFound', "%s does not exist", file)
end

names = string.empty;
groups = string.empty;

if isempty(group)
  finf = h5info(file);
else
  finf = h5info(file, group);
end

ds = finf.Datasets;
gs = finf.Groups;

if ~isempty(ds)
  names = string({ds.Name});
end

if nargout > 1 && ~isempty(gs)
  groups = string({gs.Name});
end

end % function
