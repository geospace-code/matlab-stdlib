function names = h5variables(file, group)
%% get dataset names in a file under group
% default is datasets under "/", optionally under "/group"
%
% parameters
% ----------
% file: filename
% group: group name (optional)
%
% returns
% -------
% names: variable names

arguments
  file (1,1) string {mustBeNonzeroLengthText}
  group string {mustBeScalarOrEmpty} = string.empty
end

import stdlib.fileio.expanduser

file = expanduser(file);

names = string.empty;

if isempty(group)
  finf = h5info(file);
else
  finf = h5info(file, group);
end

ds = finf.Datasets;

if isempty(ds)
  return
end

names = string({ds.Name});

end % function
