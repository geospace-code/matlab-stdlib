function [names, groups] = h5variables(filename, group)
% get dataset names and groups in an HDF5 file

narginchk(1,2)

names = [];
groups = [];

% use temporary variable to be R2017b OK
finf = h5info(hdf5nc.expanduser(filename));
ds = finf.Datasets;
if isempty(ds)
  return
end
if nargin > 1
  gs = finf.Groups;
  i = contains({gs(:).Name}, group);
  if ~any(i)
    return
  end
  ds = gs(i).Datasets;
end

names = {ds(:).Name};

if nargout > 1
  gs = finf.Groups;
  groups = {gs.Name};
end

end % function
