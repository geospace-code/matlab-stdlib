function [names, groups] = h5variables(filename)
% get dataset names and groups in an HDF5 file
narginchk(1,1)

names = [];
groups = [];

% use temporary variable to be R2017b OK
finf = h5info(expanduser(filename));
ds = finf.Datasets;
if isempty(ds)
  return
end

names = {ds(:).Name};

if nargout > 1
  groups = {finf.Groups};
end

end % function
