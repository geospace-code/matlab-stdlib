function p = parent(path)
% PARENT parent of path
arguments
  path string
end

p = stdlib.fileio.parent(path);

end