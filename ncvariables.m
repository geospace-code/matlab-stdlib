function names = ncvariables(filename)
% get dataset names and groups in an NetCDF4 file
narginchk(1,1)

% use temporary variable to be R2017b OK
finf = ncinfo(expanduser(filename));
ds = finf.Variables(:);
names = {ds(:).Name};

end % function
