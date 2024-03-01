function p = parent(path)
% PARENT parent of path
arguments
  path (1,1) string
end

p = stdlib.fileio.parent(path);

end