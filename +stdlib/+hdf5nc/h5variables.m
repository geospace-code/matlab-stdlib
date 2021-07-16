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
  file (1,1) string {mustBeNonzeroLengthText}
  group string {mustBeScalarOrEmpty} = string.empty
end

import stdlib.fileio.expanduser

file = expanduser(file);

names = string.empty;
groups = string.empty;

assert(isfile(file), "%s not found", file)

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
