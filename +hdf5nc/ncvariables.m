function names = ncvariables(filename)
% get dataset names and groups in an NetCDF4 file
arguments
  filename (1,1) string
end

finf = ncinfo(expanduser(filename));
ds = finf.Variables(:);
names = string({ds(:).Name});

end % function
