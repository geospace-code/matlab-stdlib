function last = path_tail(apath)
%% path_tail(apath)
% get last part of directory path
% if filename, return filename with suffix
arguments
  apath string {mustBeScalarOrEmpty}
end

import stdlib.fileio.absolute_path

if isempty(apath)
  last = string.empty;
  return
end

if strlength(apath) == 0
  last = "";
  return
end

[~, name, ext] = fileparts(absolute_path(apath));

last = append(name, ext);

end % function
