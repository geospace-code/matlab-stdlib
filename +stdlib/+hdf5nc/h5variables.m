function names = h5variables(file, group)
%% get dataset names in a file under group
% default is datasets under "/", optionally under "/group"
%
% parameters
% ----------
% file: filename
% group: group name (optional)
%
% returns
% -------
% names: variable names

arguments
  file (1,1) string {mustBeNonzeroLengthText}
  group (1,1) string {mustBeNonzeroLengthText} = "/"
end

import stdlib.fileio.expanduser

file = expanduser(file);

names = string.empty;

try
  finf = h5info(file, group);
catch e
  if e.identifier == "MATLAB:imagesci:h5info:unableToFind"
    return
  end
  rethrow(e)
end

ds = finf.Datasets;

if isempty(ds)
  return
end

names = string({ds.Name});

end % function
