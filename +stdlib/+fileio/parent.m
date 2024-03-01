function p = parent(path)
% PARENT parent directory of path
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getParent()
arguments
  path string
end

p = stdlib.fileio.posix(java.io.File(path).getParent());

% must drop trailing slash - need to as_posix for windows
%p = fileparts(strip(stdlib.fileio.posix(path), 'right', '/'));

end
