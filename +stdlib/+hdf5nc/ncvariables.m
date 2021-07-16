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
  file (1,1) string {mustBeNonzeroLengthText}
end

import stdlib.fileio.expanduser

file = expanduser(file);

assert(isfile(file), "%s not found", file)

finf = ncinfo(file);
ds = finf.Variables(:);
names = string({ds(:).Name});

end % function
