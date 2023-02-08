function last = path_tail(apath)
%% path_tail(apath)
% get last part of directory path
% if filename, return filename with suffix
arguments
  apath string {mustBeScalarOrEmpty}
end

last = stdlib.fileio.path_tail(apath);

end
