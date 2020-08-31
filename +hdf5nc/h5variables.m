function [names, groups] = h5variables(filename, group)
% get dataset names and groups in an HDF5 file
arguments
  filename (1,1) string
  group (1,1) string = ""
end

names = string([]);
groups = string([]);

finf = h5info(hdf5nc.expanduser(filename));
ds = finf.Datasets;
if isempty(ds)
  return
end

if group ~= ""
  gs = finf.Groups;
  i = contains({gs(:).Name}, group);
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
