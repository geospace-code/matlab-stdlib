function [names, groups] = h5variables(filename)
% get dataset names and groups in an HDF5 file
narginchk(1,1)

% use temporary variable to be R2017b OK
finf = h5info(filename);
ds = finf.Datasets;

names = {ds(:).Name};

if nargout > 1
  groups = {finf.Groups};
end

end % function
