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
  file string
end

import stdlib.fileio.expanduser

assert(length(file)<2, "one file at a time")

file = expanduser(file);

names = string.empty;

if isempty(file)
  return
end

if ~isfile(file)
  error("hdf5nc:ncvariables:fileNotFound", "%s not found.", file)
end

finf = ncinfo(file);
ds = finf.Variables(:);
names = string({ds(:).Name});

end % function
