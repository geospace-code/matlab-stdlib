function names = ncvariables(file)
% get dataset names in a file
%
% parameters
% ----------
% file: filename
%
% returns
% -------
% names: variable names

arguments
  file (1,1) string
end

file = expanduser(file);
if ~isfile(file)
  error('hdf5nc:ncvariables:fileNotFound', "%s does not exist", file)
end

finf = ncinfo(file);
ds = finf.Variables(:);
names = string({ds(:).Name});

end % function
