function last = path_tail(apath)
%% path_tail(apath)
% get last part of directory path
% if filename, return filename with suffix
arguments
  apath (1,:) string
end

import stdlib.fileio.absolute_path

[~, name, ext] = fileparts(absolute_path(apath));

last = append(name, ext);

end % function
