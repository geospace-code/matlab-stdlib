function p = parent(path)
% PARENT parent directory of path
arguments
  path string
end

% must drop trailing slash - need to as_posix for windows
p = fileparts(strip(stdlib.fileio.posix(path), 'right', '/'));

end
