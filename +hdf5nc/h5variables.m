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

names = string.empty;
groups = string.empty;

finf = h5info(expanduser(file));
ds = finf.Datasets;
if isempty(ds)
  return
end

if ~isempty(group)
  gs = finf.Groups;
  i = string({gs(:).Name}) == group;
  if ~any(i)
    return
  end
  ds = gs(i).Datasets;
end

names = string({ds(:).Name});

if nargout > 1
  gs = finf.Groups;
  groups = string({gs.Name});
end

end % function
